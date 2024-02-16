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

  static String? fieldEmpty(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return AppString.fieldCanNotBeEmpty;
    }
  }
}
