import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class InsertStudent {
  InsertStudent({required this.extra});

  // get the received data from the previous page
  Map<String, dynamic> extra;

  void InsertFirebase({required void Function() clearData}) async {


    try {
      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int ID = min + (DateTime.now().millisecond % (max - min));

      // hashed the password
      String hashedPassword = BCrypt.hashpw(extra['password'], BCrypt.gensalt());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('Firstname', isEqualTo: extra['firstName'])
          .get();

      if (querySnapshot.docs.isEmpty) {

        // Add the student to the database
        await FirebaseFirestore.instance.collection('UserData').add({
          'ID': ID,
          'Email': extra['email'],
          'FirstName': extra['firstName'],
          'LastName': extra['lastName'],
          "Gender": extra['gender'],
          'Grade': extra['grade'],
          'Section': extra['section'],
        });

        FlutterSuccess('Student added successfully');

      } else {
        FlutterError('Name already exists');
      }
    } catch (e) {
      print('An error occurred. Please try again.');
    }
  }

  Future <void> AddStudent(BuildContext context) async {

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

      // hashed the password
      String hashedPassword = BCrypt.hashpw(extra['password'], BCrypt.gensalt());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('Firstname', isEqualTo: extra['firstName'])
          .get();

      if (querySnapshot.docs.isEmpty) {

        // Add the student to the database
        await FirebaseFirestore.instance.collection('UserData').add({
          'ID': ID,
          'Email': extra['email'],
          'FirstName': extra['firstName'],
          'LastName': extra['lastName'],
          "Gender": extra['gender'],
          'Grade': extra['grade'],
          'Section': extra['section'],
        });

        FlutterSuccess('Student added successfully');

      } else {
       FlutterError('Name already exists');
      }
    } catch (e) {
      print('An error occurred. Please try again.');
    }
    finally {
      pd.close();
    }

  }

  void FlutterError(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void FlutterSuccess(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}