import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../Function/QrCodeInit.dart';

class ViewStudentQr extends StatefulWidget {
  const ViewStudentQr({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State<ViewStudentQr> {
  late Map<String, dynamic> data;
  int qrData = 0;
  ScreenshotController screenshotController = ScreenshotController();
  bool _isMounted = false;
  late int id;
  late String fullname;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    id = data['ID'];
    fullname = data['FullName'];
    _isMounted = true;
    QrCodeInit().LoadQrID(id, updateQrData, context);
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

  Future<bool> _onBackPressed() async {
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'View Student',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF6E738E),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Student Name: $fullname',
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                            final directory = (await getExternalStorageDirectory())?.path;
                            if (directory != null) {
                              final filePath = '$directory/qr_code.png';
                              screenshotController.captureAndSave(directory, fileName: 'qr_code.png').then((_) {
                                GallerySaver.saveImage(filePath).then((bool? success) {
                                  showToast(success == true ? "QR code saved to gallery" : "Failed to save QR code to gallery");
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          if (qrData != 0) {
                            final directory = (await getExternalStorageDirectory())?.path;
                            if (directory != null) {
                              final filePath = '$directory/qr_code.png';
                              screenshotController.captureAndSave(directory, fileName: 'qr_code.png').then((_) {
                                GallerySaver.saveImage(filePath).then((bool? success) {
                                  showToast(success == true ? "QR code saved to gallery" : "Failed to save QR code to gallery");
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
                              'Send me to the student email',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 18,
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