import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel{

  final String id;

  final int ID;

  final String username;

  final String status;

  UserDataModel({
    required this.id,
    required this.ID,
    required this.username,
    required this.status,

  });

  factory UserDataModel.fromDocument(DocumentSnapshot doc){
    return UserDataModel(
      id: doc.id,
      ID: doc['ID'],
      username: doc['username'],
      status: doc['role'],
    );
  }
}