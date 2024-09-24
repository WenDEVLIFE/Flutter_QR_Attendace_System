import 'package:attendance_qr_system/EmailAPI/YahooAPI.dart';
import 'package:flutter/material.dart';
import 'package:mailer/smtp_server.dart';

class EmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Send Email Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              YahooMail().sendEmail();
            },
            child: Text('Send Email'),
          ),
        ),
      ),
    );
  }


}