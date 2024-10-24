import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Component/FlutterToast.dart';

class QrCodeInit {
  Future<void> LoadQr(String fullname, Function(int) updateQrData, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('FullName', isEqualTo: fullname)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userID = userDoc['ID'].toInt();
        updateQrData(userID);

        FlutterToast().showToast('Qr Code Loaded', Colors.green);
      } else {
        FlutterToast().showToast('User not found', Colors.red);
      }
    } catch (e) {
      FlutterToast().showToast('Error fetching user profile: $e', Colors.red);
    }
  }

  Future<void> LoadQrID(int id, Function(int) updateQrData, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('ID', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userID = userDoc['ID'].toInt();
        updateQrData(userID);

        FlutterToast().showToast('Qr Code Loaded', Colors.green);
      } else {
        FlutterToast().showToast('User not found', Colors.red);
      }
    } catch (e) {
      FlutterToast().showToast('Error fetching user profile: $e', Colors.red);
    }
  }
}