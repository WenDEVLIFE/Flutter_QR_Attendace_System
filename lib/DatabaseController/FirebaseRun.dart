
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseRun {
  static Future<void> run() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
        apiKey: 'AIzaSyBVhVZIGWKvPagJgX0QW7to_U7FcjqVpXo',
        appId: '914861841567',
        messagingSenderId: '914861841567',
        projectId: 'qr-attendance-database',
    ),
    );

    if (Firebase.apps.isEmpty) {
      Fluttertoast.showToast(
          msg: "Firebase initialization failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Firebase is already initialized",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}