import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:attendance_qr_system/Function/SessionManager.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginVerification {
  final SessionManager _sessionManager = SessionManager();

  Future<void> Login({required String username, required String password, required BuildContext context}) async {
    // Show the progress dialog
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Logging in...',
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
        var userDoc = querySnapshot.docs.first;
        var RetrievePassword = userDoc['password'];
        var roles = userDoc['role'];
        var Firstname = userDoc['firstName'];
        var Lastname = userDoc['lastName'];

        final bool checkpassword = BCrypt.checkpw(password, RetrievePassword);

        if (checkpassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );

          Map<String, dynamic> userInfo = {
            'username': username,
            'firstname':Firstname,
            'lastname': Lastname,
            'role': roles,
          };

          // Save user info in session
          await _sessionManager.saveUserInfo(userInfo);

          context.go('/MainController/', extra: userInfo);

          Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password incorrect')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      // Dismiss the progress dialog
      pd.close();
    }
  }
}