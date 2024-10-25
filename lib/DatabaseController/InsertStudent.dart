import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../Component/FlutterToast.dart';

class InsertStudent {
  InsertStudent({required this.extra});

  // get the received data from the previous page
  Map<String, dynamic> extra;

  void InsertFirebase({required void Function() clearData, required BuildContext context}) async {
    try {
      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int ID = min + (DateTime.now().millisecond % (max - min));


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('FullName', isEqualTo: extra['fullName'])
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Add the student to the database
        await FirebaseFirestore.instance.collection('UserData').add({
          'ID': ID,
          'Email': extra['email'],
          'FullName': extra['fullName'],
          'Gender': extra['gender'],
          'Grade': extra['grade'],
          'Section': extra['section'],
        });

        FlutterToast().showToast('Student added successfully', Colors.green);
        context.go('/QRPage', extra: extra['fullName']);
      } else {
        FlutterToast().showToast('Name already exists', Colors.red);
      }
    } catch (e) {
      print('An error occurred. Please try again. $e');
      FlutterToast().showToast('An error occurred. Please try again.', Colors.red);
    }
  }

  Future<void> AddStudent({required void Function() clearData, required BuildContext context}) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Generating QR...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );

    try {
      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int ID = min + (DateTime.now().millisecond % (max - min));


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('FullName', isEqualTo: extra['fullName'])
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Add the student to the database
        await FirebaseFirestore.instance.collection('UserData').add({
          'ID': ID,
          'Email': extra['email'],
          'FullName': extra['fullName'],
          'Gender': extra['gender'],
          'Grade': extra['grade'],
          'Section': extra['section'],
        });

        FlutterToast().showToast('Student added successfully', Colors.green);
      } else {
        FlutterToast().showToast('Name already exists', Colors.red);
      }
    } catch (e) {
      print('An error occurred. Please try again. $e');
      FlutterToast().showToast('An error occurred. Please try again.', Colors.red);
    } finally {
      pd.close();
    }
  }
}