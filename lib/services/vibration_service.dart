
import 'package:flutter/services.dart';

class VibrationService {
  static const platform = MethodChannel('com.example.vibration/vibrate');

  static Future<void> vibrateForDuration(int milliseconds) async {
    try {
      await platform.invokeMethod('vibrate', {"duration": milliseconds});

    } on PlatformException catch (e) {
      print("Failed to vibrate: '${e.message}'.");
    }
  }
}