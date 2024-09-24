import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class YahooMail {

  String username = 'newbie_gwapo@yahoo.com';
  String password = 'mpmeoscumtccejps';

  void sendEmail() async {

    // Use Yahoo's SMTP server settings
    final smtpServer = SmtpServer('smtp.mail.yahoo.com',
        port: 587,
        username: username,
        password: password,
        ignoreBadCertificate: true);

    final message = Message()
      ..from = Address(username, 'Sending Email API')
      ..recipients.add('medinajrfrouen@gmail.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';
    //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

}