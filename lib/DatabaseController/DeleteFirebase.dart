import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Component/FlutterToast.dart';

class DeleteFirebase{

  // This is for delete attendance
  Future<void> DeleteAttendance(String id, Future<void> fetchAttendances, void Function(String message, Color backgroundColor) showToast) async {
    try {
      await FirebaseFirestore.instance.collection('Attendance').doc(id).delete();
      FlutterToast().showToast('Attendance deleted successfully', Colors.green);
      fetchAttendances;
    } catch (e) {
      print('Error deleting attendance: $e');
      FlutterToast().showToast('Error deleting attendance', Colors.red);
    }
  }

  // This is for delete the user
  Future<void> DeleteUser(Map <String, dynamic> userdata, Future<void> Function() fetchUsers) async {

   var id = userdata['id'];
   var username = userdata['username'];
   var EqualTo = userdata['EqualUsername'];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('username', isEqualTo: username).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userdoc = querySnapshot.docs.first;
        var user = userdoc['username'];

        if (user == EqualTo) {
          FlutterToast().showToast('You cannot delete your own account', Colors.red);
          return;
        }
        else{
          await FirebaseFirestore.instance.collection('Users').doc(id).delete();
          FlutterToast().showToast('User deleted successfully', Colors.green);
          fetchUsers(); // Refresh the list
        }
      }else{
        FlutterToast().showToast('User not found', Colors.red);
      }
    } catch (e) {
      print('Error deleting user: $e');
      FlutterToast().showToast('Error deleting user', Colors.red);
    }
  }
  // This is for delete the event
  Future <void> DeleteEvent(String id, Future<void> Function() fetchEvents) async{
    try {
      await FirebaseFirestore.instance.collection('Events').doc(id).delete();
      FlutterToast().showToast('Event deleted successfully', Colors.green);
      fetchEvents();
    } catch (e) {
      print('Error deleting event: $e');
      FlutterToast().showToast('Error deleting event', Colors.red);
    }
  }

  Future <void> DeleteStudent(String id, Future<void> Function() fetchStudent) async{
    try {
      await FirebaseFirestore.instance.collection('UserData').doc(id).delete();
      FlutterToast().showToast('Student deleted successfully', Colors.green);
      fetchStudent();
    } catch (e) {
      print('Error deleting student: $e');
      FlutterToast().showToast('Error deleting student', Colors.red);
    }

  }
}