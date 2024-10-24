import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final int attendanceID;
  final String date;
  final int userID;
  final String status;
  final String timeIn;
  final String fullname;
  final String grade;
  final String section;
  final double latitude;
  final double longitude;

  AttendanceModel({
    required this.id,
    required this.attendanceID,
    required this.date,
    required this.userID,
    required this.status,
    required this.timeIn,
    required this.fullname,
    required this.grade,
    required this.section,
    required this.latitude,
    required this.longitude,
  });

  factory AttendanceModel.fromDocument(DocumentSnapshot doc) {
    return AttendanceModel(
      id: doc.id,
      attendanceID: doc['AttendanceID'],
      date: doc['Date'],
      userID: doc['ID'],
      status: doc['Status'],
      timeIn: doc['Time'],
      fullname: doc['Full Name'],
      grade: doc['Grade'],
      section: doc['Section'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
    );
  }
}