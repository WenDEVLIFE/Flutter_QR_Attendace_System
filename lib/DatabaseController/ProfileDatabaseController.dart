import 'dart:io';
import 'dart:ui';

import 'package:attendance_qr_system/Component/MainController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:path/path.dart' as p;

import '../Component/FlutterToast.dart'; // Import the path package

class ProfileDatabaseController {
  Future<void> UpdateProfile(String username, String newImagePath, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Updating profile...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var user = querySnapshot.docs.first;

        // This is our retrieve file image name
        String? imageFileName = user['imageFileName'];

        if (newImagePath.isNotEmpty) {
          // Delete the old image from Firebase Storage if it exists
          if (imageFileName != null && imageFileName.isNotEmpty) {

            // this reference used to delete the image
            Reference deleteReference = FirebaseStorage.instance.ref().child('profile').child(imageFileName);
            await deleteReference.delete();
          }

          // Upload the new image
          String newFileName = p.basename(newImagePath); // Extract the filename
          Reference reference = FirebaseStorage.instance.ref().child('profile').child(newFileName);
          UploadTask uploadTask = reference.putFile(File(newImagePath));
          TaskSnapshot storageTaskSnapshot = await uploadTask;
          String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

          // Update the user's image URL and filename
          await FirebaseFirestore.instance.collection('Users').doc(user.id).update({
            'imageURL': downloadUrl,
            'imageFileName': newFileName,
          });

          Fluttertoast.showToast(
            msg: 'Profile updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          FlutterToast().showToast('No image selected', Colors.red);
        }
      } else {
        Fluttertoast.showToast(
          msg: 'User not found',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      FlutterToast().showToast('Error updating profile: $e', Colors.red);
    } finally {
      pd.close();
    }
  }
}
