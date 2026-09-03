import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  final icon = img.Image(width: 1024, height: 1024);
  final orange = img.ColorRgb8(248, 151, 8);
  final dark = img.ColorRgb8(23, 25, 31);
  img.fill(icon, color: orange);

  // Fork: four tines flow into a centered handle.
  for (final x in [250, 302, 354, 406]) {
    img.fillRect(icon, x1: x, y1: 215, x2: x + 31, y2: 435, color: dark);
  }
  img.fillRect(icon, x1: 250, y1: 390, x2: 437, y2: 500, color: dark);
  img.fillCircle(icon, x: 343, y: 500, radius: 94, color: dark);
  img.fillRect(icon, x1: 301, y1: 480, x2: 385, y2: 810, color: dark);

  // Knife: broad blade with a clear restaurant silhouette.
  img.fillRect(icon, x1: 555, y1: 215, x2: 638, y2: 810, color: dark);
  img.fillRect(icon, x1: 555, y1: 215, x2: 758, y2: 514, color: dark);
  img.fillRect(icon, x1: 638, y1: 215, x2: 758, y2: 430, color: orange);

  final outputs = <String, int>{
    'android/app/src/main/res/mipmap-mdpi/ic_launcher.png': 48,
    'android/app/src/main/res/mipmap-hdpi/ic_launcher.png': 72,
    'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png': 96,
    'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png': 144,
    'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png': 192,
    'web/icons/Icon-192.png': 192,
    'web/icons/Icon-maskable-192.png': 192,
    'web/icons/Icon-512.png': 512,
    'web/icons/Icon-maskable-512.png': 512,
    'web/favicon.png': 32,
  };
  for (final entry in outputs.entries) {
    final resized = img.copyResize(
      icon,
      width: entry.value,
      height: entry.value,
      interpolation: img.Interpolation.cubic,
    );
    File(entry.key).writeAsBytesSync(img.encodePng(resized));
  }
}
