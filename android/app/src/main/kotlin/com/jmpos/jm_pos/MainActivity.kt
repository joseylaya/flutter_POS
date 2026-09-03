package com.jmpos.jm_pos

import android.content.Context
import android.media.AudioAttributes
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
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
            vibrate(call.arguments as? String ?: "light")
            result.success(null)
        }
    }

    private fun vibrate(pattern: String) {
        val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        if (!vibrator.hasVibrator()) return

        val timings = when (pattern) {
            "selection" -> longArrayOf(0, 28)
            "medium" -> longArrayOf(0, 42)
            "heavy" -> longArrayOf(0, 65)
            "success" -> longArrayOf(0, 45, 65, 75)
            else -> longArrayOf(0, 35)
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val attributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_NOTIFICATION_EVENT)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()
            vibrator.vibrate(VibrationEffect.createWaveform(timings, -1), attributes)
        } else {
            @Suppress("DEPRECATION")
            vibrator.vibrate(timings, -1)
        }
    }
}
