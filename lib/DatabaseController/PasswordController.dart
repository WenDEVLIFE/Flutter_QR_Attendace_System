import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../Component/FlutterToast.dart';

class PasswordController{
  Future <void> PasswordDatabase(Map data, void Function() clearData, BuildContext context) async{

    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Changing Password...',
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

        var retrievePassword = userdoc['password'];

        final bool checkPassword = BCrypt.checkpw(data['oldpassword'], retrievePassword);

        if (checkPassword){
          var newPassword = BCrypt.hashpw(data['newpassword'], BCrypt.gensalt());
          await FirebaseFirestore.instance.collection('Users').doc(userdoc.id).update({'password': newPassword});
          clearData();
          FlutterToast().showToast('Password changed successfully', Colors.green);
        }
        else{
          FlutterToast().showToast('Old password is incorrect', Colors.red);
        }


      }
      else{
        FlutterToast().showToast('User not found', Colors.red);
      }


    } catch(e){
      print(e);
    }
    finally{
      pd.close();
    }

  }
}