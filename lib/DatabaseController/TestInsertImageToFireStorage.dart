import 'dart:typed_data';
import 'package:attendance_qr_system/DatabaseController/FirebaseRun.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestInsertImageToFireStorage {
  Future<void> insertImageToFireStorage() async {
    try {
      // Get Image from Assets
      ByteData data = await rootBundle.load('Assets/nature.jpg');
      Uint8List bytes = data.buffer.asUint8List();

      // Upload Image to Firebase Storage
      String fileName = 'naturee3.jpg';
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = reference.putData(bytes);
      TaskSnapshot storageTaskSnapshot = await uploadTask;

      // Get the download URL after upload is complete
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Print the URL
      print('Download URL: $downloadUrl');
      Fluttertoast.showToast(
        msg: 'Image uploaded successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
