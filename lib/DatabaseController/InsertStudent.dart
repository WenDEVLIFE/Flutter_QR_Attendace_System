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
          .collection('Users')
          .where('username', isEqualTo: extra['username'])
          .get();

      if (querySnapshot.docs.isEmpty) {

        // Get Image from Assets
        ByteData data = await rootBundle.load('Assets/nature.jpg');
        Uint8List bytes = data.buffer.asUint8List();

        var fileid = Uuid();
        // Upload Image to Firebase Storage
        String fileName = '${fileid.v1()}.jpg';
        Reference reference = FirebaseStorage.instance.ref().child('profile').child(fileName);
        UploadTask uploadTask = reference.putData(bytes);
        TaskSnapshot storageTaskSnapshot = await uploadTask;

        // Get the download URL after upload is complete
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

        // Add the student to the database
        await FirebaseFirestore.instance.collection('Users').add({
          'ID': ID,
          'username': extra['username'],
          'email': extra['email'],
          'firstName': extra['firstName'],
          'lastName': extra['lastName'],
          'course': extra['course'],
          'year': extra['year'],
          'password': hashedPassword,
          "role": "Student",
        'imageURL': downloadUrl,
        'imageFileName': fileName,

        });

        FlutterSuccess('Student added successfully');

        // Clear the data
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
      FlutterError('An error occurred. Please try again.');
    }
  }

  Future <void> AddStudent(BuildContext context) async {

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
      // Generate a random 9-digit ID
      int min = 100000000;
      int max = 999999999;
      int ID = min + (DateTime.now().millisecond % (max - min));

      // hashed the password
      String hashedPassword = BCrypt.hashpw(extra['password'], BCrypt.gensalt());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('username', isEqualTo: extra['username'])
          .get();

      if (querySnapshot.docs.isEmpty) {

        // Get Image from Assets
        ByteData data = await rootBundle.load('Assets/nature.jpg');
        Uint8List bytes = data.buffer.asUint8List();

        var fileid = Uuid();
        // Upload Image to Firebase Storage
        String fileName = '${fileid.v1()}.jpg';
        Reference reference = FirebaseStorage.instance.ref().child('profile').child(fileName);
        UploadTask uploadTask = reference.putData(bytes);
        TaskSnapshot storageTaskSnapshot = await uploadTask;

        // Get the download URL after upload is complete
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

        // Add the student to the database
        await FirebaseFirestore.instance.collection('Users').add({
          'ID': ID,
          'username': extra['username'],
          'email': extra['email'],
          'firstName': extra['firstName'],
          'lastName': extra['lastName'],
          'course': extra['course'],
          'year': extra['year'],
          'password': hashedPassword,
          "role": "Student",
        'imageURL': downloadUrl,
        'imageFileName': fileName,
        });

        FlutterSuccess('Student added successfully');

      } else {
       FlutterError('User already exists');
      }
    } catch (e) {
     FlutterError('An error occurred. Please try again.');
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