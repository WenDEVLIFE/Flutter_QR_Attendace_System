
import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class EmailController{
  Future <void> AddEmailDatabase(Map data, void Function() clearData, BuildContext context) async {
    // Email controller

    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Changing Email...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );
    try{

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('username', isEqualTo: data['username']).get();

      if (querySnapshot.docs.isNotEmpty){
        var userdoc = querySnapshot.docs.first;

        var email = userdoc['email'];
        var password = userdoc['password'];

        final bool checkPassword = BCrypt.checkpw(data['password'], password);

        if (email == data['oldEmail']){
          if (checkPassword){
            await FirebaseFirestore.instance.collection('Users').doc(userdoc.id).update({'email': data['newEmail']});
            clearData();
            Fluttertoast.showToast(
                msg: 'Email updated successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );

          } else{
            Fluttertoast.showToast(
                msg: 'Incorrect password',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        } else{
          Fluttertoast.showToast(
              msg: 'old email is incorrect',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

        }

      }
      else{
        Fluttertoast.showToast(
          msg: 'User not found',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }

    } catch (e) {
      print(e);
    }
    finally{
      pd.close();

    }
  }
}