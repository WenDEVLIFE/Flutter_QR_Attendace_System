
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Component/FlutterToast.dart';

class FirebaseRun {
  static Future<void> run() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBVhVZIGWKvPagJgX0QW7to_U7FcjqVpXo',
          appId: '1:914861841567:android:19d176eb2fc13c7c1b56aa',
          messagingSenderId: '914861841567',
          projectId: 'qr-attendance-database',
          storageBucket: 'gs://qr-attendance-database.appspot.com',  // Add this line
    ),
    );

    if (Firebase.apps.isEmpty) {
      FlutterToast().showToast("Failed to connect in the database", Colors.red);
    } else {
      FlutterToast().showToast("App connected to database successfully", Colors.green);
    }
  }
}