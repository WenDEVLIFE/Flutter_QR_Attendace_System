import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class InsertUser{

  Future  <void> InsertUsersDatabase({required Map<String, dynamic> extra, required BuildContext context, required void Function() clearData}) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Creating user...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );

    try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('username', isEqualTo: extra['username'])
            .get();

        // Generate a random 9-digit ID
        int min = 100000000;
        int max = 999999999;
        int ID = min + (DateTime.now().millisecond % (max - min));

        // hashed the password
        String hashedPassword = BCrypt.hashpw(extra['password'], BCrypt.gensalt());

    if (querySnapshot.docs.isEmpty) {
            // Add the student to the database
            await FirebaseFirestore.instance.collection('Users').add({
            'ID': ID,
            'username': extra['username'],
            'email': extra['email'],
            'firstName': extra['firstName'],
            'lastName': extra['lastName'],
            'password': hashedPassword,
            "role": extra['role']
            });

            Fluttertoast.showToast(
            msg: 'Student added successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
            );

            clearData();

    } else {
          Fluttertoast.showToast(
          msg: 'User already exists',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
          );
    }
    } catch (e) {
      print('Error creating user: $e');
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
        pd.close();
      });
    }
  }
}