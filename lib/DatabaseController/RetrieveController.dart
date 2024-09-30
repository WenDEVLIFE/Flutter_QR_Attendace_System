import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/AttendanceModel.dart';


class RetrieveController {
  Future<List<AttendanceModel>> fetchAttendances() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Attendance').get();
      return querySnapshot.docs.map((doc) => AttendanceModel.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching attendances: $e');
      return [];
    }
  }
}