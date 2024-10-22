import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../Component/FlutterToast.dart';

class ScanQr {
  Future<void> CheckAttendance(Map<String, dynamic> data, BuildContext context) async {
    try {
      int id = int.parse(data['code']);
      double latitude = data['latitude'];
      double longitude = data['longitude'];
      String selectedValue = data['attendance'];
      print("Starting Attendance method with ID: $id");
      DateTime now = DateTime.now();
      int hour = now.hour;
      int minute = now.minute;

      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int attendanceID = min + Random().nextInt(max - min);
      print("Generated AttendanceID: $attendanceID");

      // Format date to match Firestore storage format (YYYY-MM-DD)
      String formattedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      print("Formatted Date: $formattedDate");

      // Query for user
      print("Querying for user with ID: $id");
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('UserData')
          .where('ID', isEqualTo: id)
          .get();

      if (query.docs.isNotEmpty) {
        print("User found");
        var userDoc = query.docs.first;
        var FullName = userDoc['FullName'];
        var Grade = userDoc['Grade'];
        var Section = userDoc['Section'];
        print("User: $FullName");

        Map<String, dynamic> attendancedata = {
          'ID': id,
          'AttendanceID': attendanceID,
          'Full Name': FullName,
          'Date': formattedDate,
          'hour': hour,
          'minute': minute,
          'Section': Section,
          'Grade': Grade,
          'Status': selectedValue,
          'latitude': latitude,
          'longitude': longitude,
        };
        await InsertAttendance(attendancedata);
      } else {
        print("User not found");
        FlutterToast().showToast("User not found", Colors.red);
      }
    } catch (e) {
      print("Error in Attendance method: $e");
      FlutterToast().showToast("Error: ${e.toString()}", Colors.red);
    }
  }


  Future<void> InsertAttendance(Map<String, dynamic> attendancedata) async {
    String formattedDate = attendancedata['Date'];
    int id = attendancedata['ID'];
    String fullname = attendancedata['Full Name'];
    String grade = attendancedata['Grade'];
    String section = attendancedata['Section'];
    String selectedValue = attendancedata['Status'];
    int attendanceID = attendancedata['AttendanceID'];
    int hour = attendancedata['hour'];
    int minute = attendancedata['minute'];
    double latitude = attendancedata['latitude'];
    double longitude = attendancedata['longitude'];


    if (selectedValue == 'Time in') {
      QuerySnapshot checkSnapshot = await FirebaseFirestore.instance
          .collection('Attendance')
          .where('ID', isEqualTo: id)
          .where('Date', isEqualTo: formattedDate)
          .where("Status", isEqualTo: "Time In")
          .get();

      if (checkSnapshot.docs.isNotEmpty) {
        print("Attendance already exists");
        FlutterToast().showToast("You have already timed in", Colors.red);
      } else {
        print("Adding new attendance");
        // Add attendance
        await FirebaseFirestore.instance.collection('Attendance').add({
          'AttendanceID': attendanceID,
          'ID': id,
          'Full Name': fullname,
          'Date': formattedDate,
          'Status': 'Time In',
          'Grade': grade,
          'Section': section,
          'Time': '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
          'latitude': latitude,
          'longitude': longitude,
        });

        print("Attendance added successfully");
        FlutterToast().showToast("Time in successful: $fullname", Colors.green);
      }
    } else if (selectedValue == 'Time out') {
      QuerySnapshot checkSnapshot = await FirebaseFirestore.instance
          .collection('Attendance')
          .where('ID', isEqualTo: id)
          .where('Date', isEqualTo: formattedDate)
          .where("Status", isEqualTo: "Time out")
          .get();

      if (checkSnapshot.docs.isNotEmpty) {
        print("Attendance already exists");
        FlutterToast().showToast("You have already timed out", Colors.red);
      } else {
        print("Adding new attendance");
        // Add attendance
        await FirebaseFirestore.instance.collection('Attendance').add({
          'AttendanceID': attendanceID,
          'ID': id,
          'Full Name': fullname,
          'Date': formattedDate,
          'Status': 'Time out',
          'Grade': grade,
          'Section': section,
          'Time': '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
          'latitude': latitude,
          'longitude': longitude,
        });
        print("Attendance added successfully");
        FlutterToast().showToast("Time out successful: $fullname", Colors.green);
      }
    }
  }
}