import 'package:attendance_qr_system/DatabaseController/InsertStudent.dart';
import 'package:attendance_qr_system/DatabaseController/InsertUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../DatabaseController/EmailController.dart';
import '../DatabaseController/PasswordController.dart';

class VerifyDataClass {
  void CheckData(Map<String, dynamic> userData, BuildContext context, String send, void Function() clearData) {
    // Email pattern or regex
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (userData['username'].isEmpty) {
      // Show an error message
      FlutterToastError("Username is empty");
      return;
    }

    else if (userData['username'].length < 6) {
      // Show an error message
      FlutterToastError("Username must be at least 6 characters long");
      return;
    }

    else if (userData['email'].isEmpty) {
      // Show an error message
      FlutterToastError("Email is empty");
      return;
    }
    else if (userData['firstName'].isEmpty) {
      // Show an error message
      FlutterToastError("First name is empty");
      return;
    }
    else if (userData['lastName'].isEmpty) {
      // Show an error message
      FlutterToastError("Last name is empty");
      return;
    }
    else if (userData['course'].isEmpty) {
      // Show an error message
      FlutterToastError("Course is empty");
      return;
    }
    else if (userData['year'] == 'Select Year') {
      // Show an error message
      FlutterToastError("Please select a year");
      return;
    }
    else if (userData['password'].isEmpty) {
      // Show an error message
      FlutterToastError("Password is empty");
      return;
    }
    else if (userData['confirmPassword'].isEmpty) {
      // Show an error message
      FlutterToastError("Confirm password is empty");
      return;
    }
    else if (userData['password'] != userData['confirmPassword']) {
      // Show an error message
      FlutterToastError("Passwords do not match");
      return;
    }
    else if (!emailPattern.hasMatch(userData['email'])) {
      // Validate the email address
      FlutterToastError("Invalid email address");
      return;
    }
    else if (userData['password'].length < 8 || userData['confirmPassword'].length < 8) {
      // Show an error message
      FlutterToastError("Password must be at least 8 characters long");
      return;
    }
    else if (!hasSpecialCharacters(userData['password'])) {
      // Show an error message
      FlutterToastError("Password must contain at least one special character");
      return;
    }
    else if (!hasUpperCase(userData['password'])) {
      // Show an error message
      FlutterToastError("Password must contain at least one uppercase letter");
      return;
    }
    else {

      if (send=="OTP") {
        // Proceed to the next screen
        context.push('/Otp', extra: {
          'username': userData['username'],
          'email': userData['email'],
          'firstName': userData['firstName'],
          'lastName': userData['lastName'],
          'course': userData['course'],
          'year': userData['year'],
          'password': userData['password'],
        });
      }

      else if (send=="CreateStudent"){
        InsertStudent(extra: userData).InsertFirebase(clearData: clearData);
      }
    }
  }

  void CheckData2(Map<String, dynamic> userData, BuildContext context, void Function() clearData) {
    // Email pattern or regex
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (userData['username'].isEmpty) {
      // Show an error message
      FlutterToastError("Username is empty");
      return;
    }

    else if (userData['username'].length < 6) {
      // Show an error message
      FlutterToastError("Username must be at least 6 characters long");
      return;
    }


    else if (userData['email'].isEmpty) {
      // Show an error message
      FlutterToastError("Email is empty");
      return;
    }
    else if (userData['firstName'].isEmpty) {
      // Show an error message
      FlutterToastError("First name is empty");
      return;
    }
    else if (userData['lastName'].isEmpty) {
      // Show an error message
      FlutterToastError("Last name is empty");
      return;
    }
    else if (userData['role'] == 'Select a role') {
      // Show an error message
      FlutterToastError("Please select a role");
      return;
    }
    else if (userData['password'].isEmpty) {
      // Show an error message
      FlutterToastError("Password is empty");
      return;
    }
    else if (userData['confirmPassword'].isEmpty) {
      // Show an error message
      FlutterToastError("Confirm password is empty");
      return;
    } else if (userData['password'] != userData['confirmPassword']) {
      // Show an error message
      FlutterToastError("Passwords do not match");
      return;
    }
    else if (!emailPattern.hasMatch(userData['email'])) {
      // Validate the email address
     FlutterToastError("Invalid email address");
      return;
    }
    else if (userData['password'].length < 8 || userData['confirmPassword'].length < 8) {
      // Show an error message
     FlutterToastError("Password must be at least 8 characters long");
      return;
    }
    else if (!hasSpecialCharacters(userData['password'])) {
      // Show an error message
      FlutterToastError("Password must contain at least one special character");
      return;
    }
    else if (!hasUpperCase(userData['password'])) {
      // Show an error message
      FlutterToastError("Password must contain at least one uppercase letter");
      return;
    }
    else {
      // Proceed to the next screen
      Map <String, dynamic> extra = {
        'username': userData['username'],
        'email': userData['email'],
        'firstName': userData['firstName'],
        'lastName': userData['lastName'],
        'role': userData['role'],
        'password': userData['password'],
      };

      InsertUser().InsertUsersDatabase(extra : extra, context: context, clearData: clearData);
    }

  }

  void CheckPassword(Map data, void Function() clearData, BuildContext context){
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

  void checkEmail(Map data, void Function() clearData, BuildContext context){
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (data['oldEmail'].isEmpty || data['newEmail'].isEmpty) {
      // Show an error message
      FlutterToastError("Email is empty");
      return;
    }
    else if (!emailPattern.hasMatch(data['oldEmail']) || !emailPattern.hasMatch(data['newEmail'])) {
      // Validate the email address
      FlutterToastError("Invalid email address");
      return;
    }

    if (data['password'].isEmpty) {
      // Show an error message
      FlutterToastError("Password is empty");
      return;
    }
    else if (data['password'].length < 8) {
      // Show an error message
      FlutterToastError("Password must be at least 8 characters long");
      return;
    }
    else if (!hasSpecialCharacters(data['password'])) {
      // Show an error message
      FlutterToastError("Password must contain at least one special character");
      return;
    }

    else if (!hasUpperCase(data['password'])) {
      // Show an error message
      FlutterToastError("Password must contain at least one uppercase letter");
      return;
    }

    else if (data['password'] != data['confirmpassword']) {
      // Show an error message
      FlutterToastError("Passwords do not match");
      return;
    }
    else {
      EmailController().AddEmailDatabase(data, clearData, context);
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


  void FlutterToastError(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

  }

}