import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InsertStudent {
  InsertStudent({required this.extra});

  // get the received data from the previous page
  Map<String, dynamic> extra;

  void InsertFirebase() async {
    try {
      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int ID = min + (DateTime.now().millisecond % (max - min));

      // hashed the password
      String hashedPassword = BCrypt.hashpw(extra['password'], BCrypt.gensalt());

      // Add the student to the database
      await FirebaseFirestore.instance.collection('Users').add({
        'ID': ID,
        'username': extra['username'],
        'email': extra['email'],
        'firstName': extra['firstName'],
        'lastName': extra['lastName'],
        'course': extra['course'],
        'year': extra['year'],
        'password': hashedPassword,
        "role": "Student"
      });
      Fluttertoast.showToast(
          msg: 'Student added successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'An error occurred. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}