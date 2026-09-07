package com.jmpos.jm_pos

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.MediaStore
import android.util.Base64
import java.io.File
import java.security.KeyStore
import java.security.SecureRandom
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.GCMParameterSpec
import javax.crypto.spec.PBEKeySpec

object JmPosBackupManager {
    private const val PREFERENCES = "jmpos_backup"
    private const val ENCRYPTED_PASSWORD = "encrypted_password"
    private const val PASSWORD_IV = "password_iv"
    private const val LAST_BACKUP = "last_backup"
    private const val KEY_ALIAS = "jmpos_backup_password_key"
    private val magic = "JMPOSB1".toByteArray(Charsets.US_ASCII)

    fun isConfigured(context: Context): Boolean = storedPassword(context) != null

    fun configure(context: Context, password: String) {
        require(password.length >= 8) { "Backup password must contain at least 8 characters." }
        val cipher = Cipher.getInstance("AES/GCM/NoPadding")
        cipher.init(Cipher.ENCRYPT_MODE, passwordStorageKey())
        val encrypted = cipher.doFinal(password.toByteArray(Charsets.UTF_8))
        context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE).edit()
            .putString(ENCRYPTED_PASSWORD, Base64.encodeToString(encrypted, Base64.NO_WRAP))
            .putString(PASSWORD_IV, Base64.encodeToString(cipher.iv, Base64.NO_WRAP))
            .apply()
        BackupScheduler.schedule(context)
    }

    fun status(context: Context): Map<String, Any?> {
        val preferences = context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)
        return mapOf(
            "configured" to isConfigured(context),
            "lastBackupAt" to preferences.getLong(LAST_BACKUP, 0L).takeIf { it > 0 },
            "folder" to "Downloads/JmPOS/database-backup",
            "schedule" to "10:00 AM, 3:00 PM, 10:00 PM",
        )
    }

    fun createEncryptedBackup(context: Context, publish: Boolean): File {
        val password = storedPassword(context)
            ?: throw IllegalStateException("Set a backup password first.")
        val source = File(context.applicationInfo.dataDir, "app_flutter/jm_pos.sqlite")
        if (!source.exists()) throw IllegalStateException("JmPOS database was not found.")
        val staging = File(context.cacheDir, "jmpos-backup-staging.sqlite")
        if (staging.exists()) staging.delete()
        val escaped = staging.absolutePath.replace("'", "''")
        val database = android.database.sqlite.SQLiteDatabase.openDatabase(
            source.absolutePath,
            null,
            android.database.sqlite.SQLiteDatabase.OPEN_READWRITE,
        )
        try {
            database.execSQL("VACUUM INTO '$escaped'")
        } finally {
            database.close()
        }
        val stamp = SimpleDateFormat("yyyy-MM-dd_HH-mm-ss", Locale.US).format(Date())
        val encrypted = File(context.cacheDir, "jmpos-backup-$stamp.jmpos")
        encrypt(staging, encrypted, password)
        staging.delete()
        if (publish) publishToDownloads(context, encrypted)
        context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE).edit()
            .putLong(LAST_BACKUP, System.currentTimeMillis())
            .apply()
        return encrypted
    }

    fun decryptBackup(context: Context, sourcePath: String, password: String): File {
        require(password.length >= 8) { "Enter the backup password." }
        val output = File(context.cacheDir, "jmpos-restore-${System.currentTimeMillis()}.sqlite")
        decrypt(File(sourcePath), output, password)
        return output
    }

    private fun encrypt(source: File, output: File, password: String) {
        val salt = ByteArray(16).also(SecureRandom()::nextBytes)
        val iv = ByteArray(12).also(SecureRandom()::nextBytes)
        val cipher = Cipher.getInstance("AES/GCM/NoPadding")
        cipher.init(Cipher.ENCRYPT_MODE, backupKey(password, salt), GCMParameterSpec(128, iv))
        val encrypted = cipher.doFinal(source.readBytes())
        output.outputStream().use { stream ->
            stream.write(magic)
            stream.write(salt)
            stream.write(iv)
            stream.write(encrypted)
        }
    }

    private fun decrypt(source: File, output: File, password: String) {
        val bytes = source.readBytes()
        require(bytes.size > magic.size + 28 && bytes.copyOfRange(0, magic.size).contentEquals(magic)) {
            "This is not an encrypted JmPOS backup."
        }
        val saltStart = magic.size
        val salt = bytes.copyOfRange(saltStart, saltStart + 16)
        val iv = bytes.copyOfRange(saltStart + 16, saltStart + 28)
        val encrypted = bytes.copyOfRange(saltStart + 28, bytes.size)
        try {
            val cipher = Cipher.getInstance("AES/GCM/NoPadding")
            cipher.init(Cipher.DECRYPT_MODE, backupKey(password, salt), GCMParameterSpec(128, iv))
            output.writeBytes(cipher.doFinal(encrypted))
        } catch (_: Exception) {
            output.delete()
            throw IllegalArgumentException("Incorrect password or damaged backup file.")
        }
    }

    private fun backupKey(password: String, salt: ByteArray): SecretKey {
        val spec = PBEKeySpec(password.toCharArray(), salt, 150_000, 256)
        val bytes = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
            .generateSecret(spec).encoded
        return javax.crypto.spec.SecretKeySpec(bytes, "AES")
    }

    private fun passwordStorageKey(): SecretKey {
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        (keyStore.getKey(KEY_ALIAS, null) as? SecretKey)?.let { return it }
        val generator = KeyGenerator.getInstance("AES", "AndroidKeyStore")
        generator.init(
            android.security.keystore.KeyGenParameterSpec.Builder(
                KEY_ALIAS,
                android.security.keystore.KeyProperties.PURPOSE_ENCRYPT or
                    android.security.keystore.KeyProperties.PURPOSE_DECRYPT,
            ).setBlockModes(android.security.keystore.KeyProperties.BLOCK_MODE_GCM)
                .setEncryptionPaddings(android.security.keystore.KeyProperties.ENCRYPTION_PADDING_NONE)
                .build(),
        )
        return generator.generateKey()
    }

    private fun storedPassword(context: Context): String? {
        val preferences = context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)
        val encrypted = preferences.getString(ENCRYPTED_PASSWORD, null) ?: return null
        val iv = preferences.getString(PASSWORD_IV, null) ?: return null
        return try {
            val cipher = Cipher.getInstance("AES/GCM/NoPadding")
            cipher.init(
                Cipher.DECRYPT_MODE,
                passwordStorageKey(),
                GCMParameterSpec(128, Base64.decode(iv, Base64.NO_WRAP)),
            )
            String(
                cipher.doFinal(Base64.decode(encrypted, Base64.NO_WRAP)),
                Charsets.UTF_8,
            )
        } catch (_: Exception) {
            null
        }
    }

    private fun publishToDownloads(context: Context, file: File) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            throw IllegalStateException("Automatic public backups require Android 10 or newer.")
        }
        val values = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, file.name)
            put(MediaStore.Downloads.MIME_TYPE, "application/octet-stream")
            put(MediaStore.Downloads.RELATIVE_PATH, "Download/JmPOS/database-backup")
            put(MediaStore.Downloads.IS_PENDING, 1)
        }
        val resolver = context.contentResolver
        val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
            ?: throw IllegalStateException("Unable to create the backup file.")
        try {
            resolver.openOutputStream(uri)?.use { output ->
                file.inputStream().use { input -> input.copyTo(output) }
            } ?: throw IllegalStateException("Unable to write the backup file.")
            values.clear()
            values.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(uri, values, null, null)
        } catch (error: Exception) {
            resolver.delete(uri, null, null)
            throw error
        }
    }
}

object BackupScheduler {
    private val hours = intArrayOf(10, 15, 22)

    fun schedule(context: Context) {
        if (!JmPosBackupManager.isConfigured(context)) return
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        for ((index, hour) in hours.withIndex()) {
            val intent = Intent(context, ScheduledBackupReceiver::class.java)
                .putExtra("slot", index)
            val pending = PendingIntent.getBroadcast(
                context,
                7100 + index,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            alarmManager.setAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                nextTime(hour),
                pending,
            )
        }
    }

    private fun nextTime(hour: Int): Long {
        val now = Calendar.getInstance()
        return Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
            if (!after(now)) add(Calendar.DAY_OF_YEAR, 1)
        }.timeInMillis
    }
}

class ScheduledBackupReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val pending = goAsync()
        Thread {
            try {
                JmPosBackupManager.createEncryptedBackup(context, publish = true)
            } finally {
                BackupScheduler.schedule(context)
                pending.finish()
            }
        }.start()
    }
}

class BackupBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        BackupScheduler.schedule(context)
    }
}
