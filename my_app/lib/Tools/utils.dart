import 'dart:io' show Platform;
import 'package:email_validator/email_validator.dart';
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

class MyUtils {
  static bool checkFormValidity(
    String email,
    String password,
    String passwordConfirm,
  ) {
    if (email.isEmpty ||
        password.isEmpty ||
        passwordConfirm.isEmpty ||
        EmailValidator.validate(email) == false ||
        password != passwordConfirm) {
      return false;
    }
    return true;
  }

  static (bool, String) checkFormValidityV2(
    String email,
    String password,
    String passwordConfirm,
  ) {
    if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      return (false, 'Please fill all the fields');
    }
    if (EmailValidator.validate(email) == false) {
      return (false, 'Please enter a valid email');
    }
    if (password != passwordConfirm) return (false, 'Passwords do not match');
    return (true, '');
  }

  static bool checkFormValidityLogin(
    String email,
    String password,
  ) {
    if (email.isEmpty ||
        password.isEmpty ||
        EmailValidator.validate(email) == false) {
      return false;
    }
    return true;
  }
}
