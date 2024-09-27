import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import '../DatabaseController/FirebaseRun.dart';

class ScanQr {
  Future<void> Attendance(String id) async {
    try {
      print("Starting Attendance method with ID: $id");

      await FirebaseRun.run();
      print("Firebase initialized");

      DateTime now = DateTime.now();
      int hour = now.hour;
      int minute = now.minute;
      int ID = int.parse(id);
      print("Parsed ID: $ID");

      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int attendanceID = min + Random().nextInt(max - min);
      print("Generated AttendanceID: $attendanceID");

      // Format date to match Firestore storage format (YYYY-MM-DD)
      String formattedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      print("Formatted Date: $formattedDate");

      // Query for user
      print("Querying for user with ID: $ID");
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('Users')
          .where('ID', isEqualTo: ID)
          .get();

      if (query.docs.isNotEmpty) {
        print("User found");
        var userDoc = query.docs.first;
        var firstname = userDoc['firstName'];
        var lastname = userDoc['lastName'];
        print("User: $firstname $lastname");
        InsertAttendance( ID, attendanceID, firstname, lastname, formattedDate, hour, minute);



      } else {
        print("User not found");
        _showToast("User not found", Colors.red);
      }
    } catch (e) {
      print("Error in Attendance method: $e");
      _showToast("Error: ${e.toString()}", Colors.red);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    print("Showing toast: $message");
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future <void> InsertAttendance(int id , int attendanceID, String firstname, String lastname, String formattedDate, int hour, int minute) async {
    QuerySnapshot checkSnapshot = await FirebaseFirestore.instance
        .collection('Attendance')
        .where('ID', isEqualTo: id)
        .where('Date', isEqualTo: formattedDate)
        .where("Status", isEqualTo: "Time In")
        .get();

    if (checkSnapshot.docs.isNotEmpty) {
      print("Attendance already exists");
      _showToast("You have already timed in", Colors.red);
    } else {
      print("Adding new attendance");
      // Add attendance
      await FirebaseFirestore.instance.collection('Attendance').add({
        'AttendanceID': attendanceID,
        'ID': id,
        'firstName': firstname,
        'lastName': lastname,
        'Date': formattedDate,
        'Status': 'Time In',
        'TimeIn': '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      });

      print("Attendance added successfully");
      _showToast("Time in successful: $firstname $lastname", Colors.green);
    }
  }
}