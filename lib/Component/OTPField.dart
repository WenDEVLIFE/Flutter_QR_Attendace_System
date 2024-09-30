import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for FilteringTextInputFormatter
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../DatabaseController/InsertStudent.dart';

class OTPField extends StatelessWidget {
  final List<TextEditingController> controllers;

  const OTPField({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return _buildOTPField(context, index);
      }),
    );
  }

  Widget _buildOTPField(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: 40,
      child: TextField(
        controller: controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Add this line
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  void OTPVerification(int otp, BuildContext context, Map<String, dynamic> extra) {
    String enteredOTP = controllers.map((controller) => controller.text).join();
    if (enteredOTP == otp.toString()) {
      print('OTP is correct');
      InsertStudent(extra: extra).InsertFirebase(clearData: clearData);
      context.go('/Loginpage');
    } else {
      Fluttertoast.showToast(
          msg: 'Incorrect OTP. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void clearData() {
    controllers.forEach((controller) => controller.clear());
  }
}