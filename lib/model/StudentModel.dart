import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String id;

  int studentID;

  String FullName;

  String Grade;

  String Section;

  String Gender;


  StudentModel({
    required this.id,
    required this.studentID,
    required this.FullName,
    required this.Grade,
    required this.Section,
    required this.Gender,
  });

  factory StudentModel.fromDocument(DocumentSnapshot doc) {
    return StudentModel(
      id: doc.id,
      studentID: doc['ID'],
      FullName: doc['FullName'],
      Grade: doc['Grade'],
      Section: doc['Section'],
      Gender: doc['Gender']
    );
  }
}