import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class MyPlatform {
  static bool isAndroid() {
    if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }

  static bool isIOS() {
    if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  static bool isWeb() {
    if (kIsWeb) {
      return true;
    } else {
      return false;
    }
  }

  static String getPlatform() {
    if (kIsWeb) {
      return 'Web';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else {
      return 'Unknown';
    }
  }
}
