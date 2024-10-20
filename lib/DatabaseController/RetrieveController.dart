import 'package:attendance_qr_system/model/UserDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Component/FlutterToast.dart';
import '../model/AttendanceModel.dart';


class RetrieveController {

  // This is for fetch the attendance
  Future<List<AttendanceModel>> fetchAttendances() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Attendance').get();
      return querySnapshot.docs.map((doc) => AttendanceModel.fromDocument(doc)).toList();
    } catch (e) {
      FlutterToast().showToast('Error fetching attendance: $e', Colors.red);
      return [];
    }
  }

  // This is for fetching user
  Future<List<UserDataModel>> fetchUser() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').get();
      return querySnapshot.docs.map((doc) => UserDataModel.fromDocument(doc)).toList();
    } catch (e) {
      FlutterToast().showToast('Error fetching users: $e', Colors.red);
      return [];
    }
  }

  Future<Map<String, String>> LoadUserProfile(String username) async {
    String fullname = '';
    String role = '';
    String imageURL = '';

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('username', isEqualTo: username) // Use the variable `username` instead of the string 'username'
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        role = userDoc['role'];
        fullname = '${userDoc['firstName']} ${userDoc['lastName']}'; // Construct fullname
        imageURL = userDoc['imageURL'];
      }
    } catch (e) {
      FlutterToast().showToast('Error fetching user profile: $e', Colors.red);
    }

    return {
      'fullname': fullname,
      'role': role,
      'imageURL': imageURL,
    };
  }

}