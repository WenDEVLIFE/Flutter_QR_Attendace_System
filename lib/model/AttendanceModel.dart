import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final int attendanceID;
  final String date;
  final int userID;
  final String status;
  final String timeIn;
  final String userType;
  final String firstName;
  final String lastName;

  AttendanceModel({
    required this.id,
    required this.attendanceID,
    required this.date,
    required this.userID,
    required this.status,
    required this.timeIn,
    required this.userType,
    required this.firstName,
    required this.lastName,
  });

  factory AttendanceModel.fromDocument(DocumentSnapshot doc) {
    return AttendanceModel(
      id: doc.id,
      attendanceID: doc['AttendanceID'],
      date: doc['Date'],
      userID: doc['ID'],
      status: doc['Status'],
      timeIn: doc['TimeIn'],
      userType: doc['UserType'],
      firstName: doc['firstName'],
      lastName: doc['lastName'],
    );
  }
}