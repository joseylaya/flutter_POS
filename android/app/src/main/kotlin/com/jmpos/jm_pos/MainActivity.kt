package com.jmpos.jm_pos

import android.content.Context
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.ToneGenerator
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest
import java.security.SecureRandom
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

class MainActivity : FlutterActivity() {
    private var toneGenerator: ToneGenerator? = null

    companion object {
        private const val ACTIVATION_CHANNEL = "com.jmpos.jm_pos/activation"
        private const val ACTIVATION_PREFERENCES = "jmpos_activation"
        private const val ACTIVATED_DEVICE = "activated_device"
        private const val REQUEST_PIN = "request_pin"
        private const val FAILED_ATTEMPTS = "failed_attempts"
        private const val LOCKED_UNTIL = "locked_until"
        private const val PIN_SECRET_HEX =
            "d685a019bbb1e6eaf331d6169e93bedd3aea947e6bc566dfcb8d9e8f9d6c58ab"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.jmpos.jm_pos/haptics",
        ).setMethodCallHandler { call, result ->
            if (call.method != "vibrate") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val pattern = call.arguments as? String ?: "light"
            playTick(pattern)
            vibrate(pattern)
            result.success(null)
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ACTIVATION_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getActivationStatus" -> result.success(activationStatus())
                "activate" -> {
                    val pin = call.argument<String>("pin")?.trim().orEmpty()
                    try {
                        result.success(activate(pin))
                    } catch (error: IllegalArgumentException) {
                        result.error(
                            "INVALID_LICENSE",
                            error.message ?: "Invalid activation PIN.",
                            null,
                        )
                    } catch (_: Exception) {
                        result.error(
                            "INVALID_LICENSE",
                            "The activation PIN could not be verified.",
                            null,
                        )
                    }
                }
                else -> result.notImplemented()
            }
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.jmpos.jm_pos/backup",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "status" -> result.success(JmPosBackupManager.status(this))
                "configure" -> {
                    try {
                        val password = call.argument<String>("password").orEmpty()
                        JmPosBackupManager.configure(this, password)
                        result.success(JmPosBackupManager.status(this))
                    } catch (error: Exception) {
                        result.error("BACKUP_ERROR", error.message, null)
                    }
                }
                "create" -> runBackupTask(result) {
                    JmPosBackupManager.createEncryptedBackup(this, publish = false).absolutePath
                }
                "backupNow" -> runBackupTask(result) {
                    JmPosBackupManager.createEncryptedBackup(this, publish = true)
                    JmPosBackupManager.status(this)
                }
                "decrypt" -> runBackupTask(result) {
                    val path = call.argument<String>("path").orEmpty()
                    val password = call.argument<String>("password").orEmpty()
                    JmPosBackupManager.decryptBackup(this, path, password).absolutePath
                }
                else -> result.notImplemented()
            }
        }
        BackupScheduler.schedule(this)
    }

    private fun runBackupTask(
        result: MethodChannel.Result,
        action: () -> Any?,
    ) {
        Thread {
            try {
                val value = action()
                runOnUiThread { result.success(value) }
            } catch (error: Exception) {
                runOnUiThread {
                    result.error(
                        "BACKUP_ERROR",
                        error.message ?: "Backup operation failed.",
                        null,
                    )
                }
            }
        }.start()
    }

    private fun installationId(): String {
        val androidId = Settings.Secure.getString(
            contentResolver,
            Settings.Secure.ANDROID_ID,
        ) ?: "unknown-device"
        val digest = MessageDigest.getInstance("SHA-256")
            .digest("$packageName|$androidId".toByteArray(Charsets.UTF_8))
        val compact = digest.take(10).joinToString("") { "%02X".format(it) }
        return compact.chunked(4).joinToString("-")
    }

    private fun activationStatus(): Map<String, Any?> {
        val preferences = getSharedPreferences(
            ACTIVATION_PREFERENCES,
            Context.MODE_PRIVATE,
        )
        val deviceId = installationId()
        val activated = preferences.getString(ACTIVATED_DEVICE, null) == deviceId
        return mapOf(
            "activated" to activated,
            "installationId" to deviceId,
            "requestPin" to getOrCreateRequestPin(),
            "businessName" to if (activated) "Licensed installation" else null,
        )
    }

    private fun activate(pin: String): Map<String, Any?> {
        if (!pin.matches(Regex("^[0-9]{6}$"))) {
            throw IllegalArgumentException("Enter the six-digit activation PIN.")
        }
        val preferences = getSharedPreferences(
            ACTIVATION_PREFERENCES,
            Context.MODE_PRIVATE,
        )
        val now = System.currentTimeMillis()
        val lockedUntil = preferences.getLong(LOCKED_UNTIL, 0)
        if (lockedUntil > now) {
            val minutes = ((lockedUntil - now + 59_999) / 60_000).coerceAtLeast(1)
            throw IllegalArgumentException("Too many attempts. Try again in $minutes minute(s).")
        }
        if (lockedUntil != 0L) {
            preferences.edit().remove(LOCKED_UNTIL).putInt(FAILED_ATTEMPTS, 0).apply()
        }
        val expected = activationPin(getOrCreateRequestPin())
        if (pin != expected) {
            val attempts = preferences.getInt(FAILED_ATTEMPTS, 0) + 1
            val editor = preferences.edit().putInt(FAILED_ATTEMPTS, attempts)
            if (attempts >= 5) {
                editor.putLong(LOCKED_UNTIL, now + 5 * 60_000L)
            }
            editor.apply()
            val remaining = (5 - attempts).coerceAtLeast(0)
            throw IllegalArgumentException(
                if (remaining == 0) {
                    "Too many incorrect PINs. Try again in 5 minutes."
                } else {
                    "Incorrect activation PIN. $remaining attempt(s) remaining."
                },
            )
        }
        preferences.edit()
            .putString(ACTIVATED_DEVICE, installationId())
            .remove(FAILED_ATTEMPTS)
            .remove(LOCKED_UNTIL)
            .apply()
        return activationStatus()
    }

    private fun getOrCreateRequestPin(): String {
        val preferences = getSharedPreferences(
            ACTIVATION_PREFERENCES,
            Context.MODE_PRIVATE,
        )
        preferences.getString(REQUEST_PIN, null)?.let { return it }
        val pin = "%06d".format(SecureRandom().nextInt(1_000_000))
        preferences.edit().putString(REQUEST_PIN, pin).apply()
        return pin
    }

    private fun activationPin(requestPin: String): String {
        val secret = PIN_SECRET_HEX.chunked(2)
            .map { it.toInt(16).toByte() }
            .toByteArray()
        val mac = Mac.getInstance("HmacSHA256")
        mac.init(SecretKeySpec(secret, "HmacSHA256"))
        val digest = mac.doFinal(requestPin.toByteArray(Charsets.UTF_8))
        val value = ((digest[0].toLong() and 0xff) shl 24) or
            ((digest[1].toLong() and 0xff) shl 16) or
            ((digest[2].toLong() and 0xff) shl 8) or
            (digest[3].toLong() and 0xff)
        return "%06d".format(value % 1_000_000)
    }

    private fun playTick(pattern: String) {
        // A short acknowledgement tone stays crisp on rapid cashier taps.
        // Stop the previous tone first so repeated product taps never overlap.
        val generator = toneGenerator ?: ToneGenerator(
            AudioManager.STREAM_MUSIC,
            72,
        ).also { toneGenerator = it }
        generator.stopTone()
        val tone = if (pattern == "success") {
            ToneGenerator.TONE_PROP_ACK
        } else {
            ToneGenerator.TONE_PROP_BEEP2
        }
        generator.startTone(tone, if (pattern == "success") 55 else 28)
    }

    override fun onDestroy() {
        toneGenerator?.release()
        toneGenerator = null
        super.onDestroy()
    }

    private fun vibrate(pattern: String) {
        val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        if (!vibrator.hasVibrator()) return

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val attributes = AudioAttributes.Builder()
                // Some Samsung devices completely suppress USAGE_TOUCH when
                // system touch vibration is disabled. JmPOS feedback is an
                // explicit cashier confirmation, so keep it independently
                // perceptible while still respecting DND.
                .setUsage(AudioAttributes.USAGE_ALARM)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()
            val effect = when (pattern) {
                "selection" -> VibrationEffect.createOneShot(
                    48,
                    VibrationEffect.DEFAULT_AMPLITUDE,
                )
                "medium" -> VibrationEffect.createOneShot(
                    65,
                    VibrationEffect.DEFAULT_AMPLITUDE,
                )
                "heavy" -> VibrationEffect.createOneShot(
                    82,
                    VibrationEffect.DEFAULT_AMPLITUDE,
                )
                "success" -> VibrationEffect.createWaveform(
                    longArrayOf(0, 58, 55, 88),
                    -1,
                )
                else -> VibrationEffect.createOneShot(
                    58,
                    VibrationEffect.DEFAULT_AMPLITUDE,
                )
            }
            vibrator.vibrate(effect, attributes)
        } else {
            val timings = when (pattern) {
                "selection" -> longArrayOf(0, 48)
                "medium" -> longArrayOf(0, 65)
                "heavy" -> longArrayOf(0, 82)
                "success" -> longArrayOf(0, 58, 55, 88)
                else -> longArrayOf(0, 58)
            }
            @Suppress("DEPRECATION")
            vibrator.vibrate(timings, -1)
        }
    }
}
