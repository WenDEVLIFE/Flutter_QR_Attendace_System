import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

import '../Component/FlutterToast.dart';

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

          // Get Image from Assets
          ByteData data = await rootBundle.load('Assets/nature.jpg');
          Uint8List bytes = data.buffer.asUint8List();

          var fileid = const Uuid();
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
            'password': hashedPassword,
            "role": extra['role'],
            'imageURL': downloadUrl,
              'imageFileName': fileName,
            });

          FlutterToast().showToast('User created successfully', Colors.green);
            clearData();

    } else {
      FlutterToast().showToast('Username already exists', Colors.red);
    }
    } catch (e) {
      FlutterToast().showToast('Error creating user: $e', Colors.red);
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
        pd.close();
      });
    }
  }
}