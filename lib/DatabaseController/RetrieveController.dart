import 'package:attendance_qr_system/model/UserDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/AttendanceModel.dart';


class RetrieveController {

  // This is for fetch the attendance
  Future<List<AttendanceModel>> fetchAttendances() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Attendance').get();
      return querySnapshot.docs.map((doc) => AttendanceModel.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching attendances: $e');
      return [];
    }
  }

  // This is for fetching user
  Future<List<UserDataModel>> fetchUser() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').get();
      return querySnapshot.docs.map((doc) => UserDataModel.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }

  }
}