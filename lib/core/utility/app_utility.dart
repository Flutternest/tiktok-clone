import 'dart:math';

import 'package:tiktokclone/core/constants/constants.dart';

class AppUtils {
  static bool emailValidation(String value) {
    final validEmail =
        RegExp(r"^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$");
    return validEmail.hasMatch(value);
  }

  static String? emailValidate(String? value) {
    if (value!.isNotEmpty) {
      if (emailValidation(value.trim())) {
        return null;
      } else {
        return AppString.invalidEmail;
      }
    } else {
      return AppString.enterYourEmail;
    }
  }

  static String? passwordValidate(String? value) {
    if (value!.isNotEmpty) {
      if (value.length < 6) {
        return AppString.passwordValidation;
      } else {
        return null;
      }
    } else {
      return AppString.enterYourPassword;
    }
  }
  static String generateUsername(String familyName) {
    Random random = Random();
    int threeDigitNumber = random.nextInt(900) + 100;
    return '$familyName$threeDigitNumber';
  }

  static String extractFirstName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    if (nameParts.isNotEmpty) {
      return nameParts[0];
    } else {
      return '';
    }
  }

  static String extractLastName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    if (nameParts.length == 2) {
      return nameParts[1];
    } else if (nameParts.isNotEmpty) {
      return nameParts[0];
    } else {
      return '';
    }
  }


  static String? fieldEmpty(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return AppString.fieldCanNotBeEmpty;
    }
  }
}
