import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteFirebase{

  // This is for delete attendance
  Future<void> DeleteAttendance(String id, Future<void> fetchAttendances, void Function(String message, Color backgroundColor) _showToast) async {
    try {
      await FirebaseFirestore.instance.collection('Attendance').doc(id).delete();
      _showToast('Attendance deleted successfully', Colors.green);
      fetchAttendances;
    } catch (e) {
      print('Error deleting attendance: $e');
      _showToast('Error deleting attendance', Colors.red);
    }
  }

  // This is for delete the user
  Future<void> DeleteUser(String id, Future<void> Function() fetchUsers, void Function(String message, Color backgroundColor) showToast, String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('username', isEqualTo: username).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userdoc = querySnapshot.docs.first;
        var user = userdoc['username'];

        if (user == username) {
          showToast('Cannot delete yourself', Colors.red);
          return;
        }
        else{
          await FirebaseFirestore.instance.collection('Users').doc(id).delete();
          showToast('User deleted successfully', Colors.green);
          fetchUsers(); // Refresh the list
        }
      }else{
        showToast('User not found', Colors.green);
      }
    } catch (e) {
      print('Error deleting user: $e');
      showToast('Error deleting user', Colors.red);
    }
  }
}