import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../Function/QrCodeInit.dart';

class Qrpage extends StatefulWidget {
  final String firstname;

  const Qrpage({super.key, required this.firstname});

  @override
  QrState createState() => QrState();
}

class QrState extends State<Qrpage> {
  late String firstname;
  int qrData = 0;
  ScreenshotController screenshotController = ScreenshotController();
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    firstname = widget.firstname;
    QrCodeInit().LoadQr(firstname, updateQrData, context);
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  void updateQrData(int data) {
    if (_isMounted) {
      setState(() {
        qrData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back to the main page
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Successfully Registered',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Here is your Qr Code',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: QrImageView(
                            data: qrData.toString(),
                            version: QrVersions.auto,
                            size: 300.0,
                            gapless: false,
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          if (qrData != 0) {
                            final directory = (await getExternalStorageDirectory())
                                ?.path;
                            if (directory != null) {
                              final filePath = '$directory/qr_code.png';
                              screenshotController.captureAndSave(
                                  directory, fileName: 'qr_code.png').then((_) {
                                GallerySaver.saveImage(filePath).then((
                                    bool? success) {
                                  showToast(success == true
                                      ? "QR code saved to gallery"
                                      : "Failed to save QR code to gallery");
                                });
                              }).catchError((error) {
                                showToast("Failed to save QR code: $error");
                              });
                            } else {
                              showToast("Failed to get storage directory");
                            }
                          } else {
                            showToast("QR code is not available");
                          }
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.download_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Download Me',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}