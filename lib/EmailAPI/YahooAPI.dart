import 'package:attendance_qr_system/Key/EmailKey.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class YahooMail {

  // get the api key from EmailKey.dart
  String username = EmailKey().emailKey;
  String password = EmailKey().appkey;

  void sendEmail(int otp, String recipient, Function(bool) setLoading, BuildContext context) async {
    setLoading(true); // Start loading

    final smtpServer = SmtpServer('smtp.mail.yahoo.com',
        port: 587,
        username: username,
        password: password,
        ignoreBadCertificate: true);

    final message = Message()
      ..from = Address(username, 'QR Code Management System')
      ..recipients.add(recipient)
      ..subject = 'OTP for QR Code Management System'
      ..text = 'Your OTP is $otp. Please enter this OTP to proceed.';

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(
          msg: 'OTP sent to your email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    } finally {
      setLoading(false); // Stop loading
    }
  }
}