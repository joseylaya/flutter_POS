import 'package:flutter/services.dart';

class AppHaptics {
  AppHaptics._();

  static const _channel = MethodChannel('com.jmpos.jm_pos/haptics');

  static Future<void> selection() =>
      _vibrate('selection', HapticFeedback.mediumImpact);

  static Future<void> light() => _vibrate('light', HapticFeedback.heavyImpact);

  static Future<void> medium() =>
      _vibrate('medium', HapticFeedback.mediumImpact);

  static Future<void> heavy() => _vibrate('heavy', HapticFeedback.heavyImpact);

  static Future<void> success() =>
      _vibrate('success', HapticFeedback.heavyImpact);

  static Future<void> _vibrate(
    String pattern,
    Future<void> Function() fallback,
  ) async {
    try {
      await _channel.invokeMethod<void>('vibrate', pattern);
    } on MissingPluginException {
      await fallback();
      await SystemSound.play(SystemSoundType.click);
    } on PlatformException {
      await fallback();
      await SystemSound.play(SystemSoundType.click);
    }
  }
}
