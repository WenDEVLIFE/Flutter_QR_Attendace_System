import 'package:attendance_qr_system/DatabaseController/InsertStudent.dart';
import 'package:attendance_qr_system/DatabaseController/InsertUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class VerifyDataClass {
  void CheckData(Map<String, dynamic> userData, BuildContext context) {
    // Email pattern or regex
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (userData['username'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Username is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    else if (userData['username'].length < 6) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Username must be at least 6 characters long",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }


    else if (userData['email'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Email is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['firstName'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "First name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['lastName'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Last name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['course'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Course is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['year'] == 'Select Year') {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Please select a year",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['password'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['confirmPassword'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Confirm password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['password'] != userData['confirmPassword']) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Passwords do not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (!emailPattern.hasMatch(userData['email'])) {
      // Validate the email address
      Fluttertoast.showToast(
        msg: "Invalid email address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['password'].length < 8 || userData['confirmPassword'].length < 8) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password must be at least 8 characters long",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (!hasSpecialCharacters(userData['password'])) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password must contain at least one special character",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (!hasUpperCase(userData['password'])) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password must contain at least one uppercase letter",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else {
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
  }

  void CheckData2(Map<String, dynamic> userData, BuildContext context, void Function() clearData) {
    // Email pattern or regex
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (userData['username'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Username is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    else if (userData['username'].length < 6) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Username must be at least 6 characters long",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }


    else if (userData['email'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Email is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['firstName'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "First name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['lastName'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Last name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['role'] == 'Select a role') {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Please select a year",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['password'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['confirmPassword'].isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Confirm password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['password'] != userData['confirmPassword']) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Passwords do not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (!emailPattern.hasMatch(userData['email'])) {
      // Validate the email address
      Fluttertoast.showToast(
        msg: "Invalid email address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (userData['password'].length < 8 || userData['confirmPassword'].length < 8) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password must be at least 8 characters long",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (!hasSpecialCharacters(userData['password'])) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password must contain at least one special character",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else if (!hasUpperCase(userData['password'])) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password must contain at least one uppercase letter",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else {
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