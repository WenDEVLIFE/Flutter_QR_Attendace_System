import 'dart:io';
import 'dart:ui';

import 'package:attendance_qr_system/Key/EmailKey.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class YahooMail {

  // Get the API key from EmailKey.dart
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

  void SendEmailQR(String email, void Function(bool isLoading) setLoading, BuildContext context, String fullname, String data) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Sending it to $email...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );
    setLoading(true); // Start loading

    final smtpServer = SmtpServer('smtp.mail.yahoo.com',
        port: 587,
        username: username,
        password: password,
        ignoreBadCertificate: true);

    final qrFile = await generateQRCodeImage(data); // Generate the QR code image with the desired data

    final message = Message()
      ..from = Address(username, 'QR Code Management System')
      ..recipients.add(email)
      ..subject = 'QR Code for $fullname'
      ..text = 'Hello $fullname, \n\nPlease find the attached QR code for your attendance. \n\nThank you.'
      ..attachments.add(FileAttachment(qrFile)); // Attach the QR code image

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(
          msg: 'QR code sent to the student email',  // Updated message
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
      Future.delayed(const Duration(seconds: 2), () {
        pd.close();
      });
      setLoading(false); // Stop loading
    }
  }

  Future<File> generateQRCodeImage(String data) async {
    final qrImage = await QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
    ).toImage(200);

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/qr_image.png';
    final file = File(filePath);
    await file.writeAsBytes(await qrImage.toByteData(format: ImageByteFormat.png).then((byteData) => byteData!.buffer.asUint8List()));

    return file;
  }
}
