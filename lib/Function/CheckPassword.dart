import 'package:attendance_qr_system/DatabaseController/PasswordController.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckPassword {
  void checkPassword(Map data, void Function() clearData, BuildContext context) {
    if (data['oldpassword'] == data['newpassword']) {
      print('Old password and new password cannot be the same');
    } else if (data['newpassword'].length < 8) {
      print('Password must be at least 8 characters long');
    } else if (!hasUpperCase(data['newpassword'])) {
      print('Password must contain at least one uppercase letter');
    } else if (!hasSpecialCharacters(data['newpassword'])) {
      print('Password must contain at least one special character');
    } else {
      PasswordController().PasswordDatabase(data, clearData, context);

    }
  }

  bool hasSpecialCharacters(String value) {
    String pattern = r'[^a-zA-Z0-9\s]';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool hasUpperCase(String value) {
    String pattern = r'[A-Z]';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}