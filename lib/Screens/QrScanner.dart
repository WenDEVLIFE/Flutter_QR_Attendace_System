import 'package:attendance_qr_system/DatabaseController/ScanQR.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as mlkit; // Alias for google_ml_kit
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr; // Alias for qr_code_scanner
import 'dart:io';

import 'package:sn_progress_dialog/progress_dialog.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  QrState createState() => QrState();
}

class QrState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  qr.Barcode? result; // Use the alias for qr_code_scanner
  qr.QRViewController? controller;
  String? _selectedValue;

  final List<String> _items = ['Select to attendance', 'Time in', 'Time out'];

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = _items.isNotEmpty ? _items[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Scanner',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
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
          children: <Widget>[
            Expanded(
              flex: 6,
              child: qr.QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: qr.QrScannerOverlayShape(
                  borderColor: Colors.blue,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedValue,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      items: _items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () async {
                  // Pick an image from the gallery
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    // Scan the QR code from the image
                    await _scanQRCodeFromImage(File(pickedFile.path));
                  }
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Upload QR',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(qr.QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print('Scanned QR Code: ${scanData.code}'); // Debug statement
      });
      _processQRCode(scanData.code);
    });
  }

  Future<void> _scanQRCodeFromImage(File image) async {
    final inputImage = mlkit.InputImage.fromFile(image);
    final mlkit.BarcodeScanner barcodeScanner = mlkit.GoogleMlKit.vision.barcodeScanner();

    try {
      final List<mlkit.Barcode> barcodes = await barcodeScanner.processImage(inputImage);
      for (mlkit.Barcode barcode in barcodes) {
        _processQRCode(barcode.displayValue);
      }
    } catch (e) {
      print('Error scanning QR code from image: $e');
    } finally {
      barcodeScanner.close();
    }
  }

  void _processQRCode(String? code) {
    if (code != null) {
      print('Processing QR Code: $code'); // Debug statement
      if (_selectedValue == 'Select to attendance') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF6E738E),
              title: const Text(
                'Select to attendance',
                style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 30),
              ),
              content: const Text(
                'Please select the attendance type',
                style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = _items[1]; // Time in
                    });
                    Navigator.pop(context);
                    ScanQr().CheckAttendance(code, _selectedValue!, context); // Process time out
                  },
                  child: const Text(
                    'Time in',
                    style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = _items[2]; // Time out
                    });
                    Navigator.pop(context);
                    ScanQr().CheckAttendance(code, _selectedValue!, context); // Process time out
                  },
                  child: const Text(
                    'Time out',
                    style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print('Scanned QR Code: $code');
        Fluttertoast.showToast(
          msg: 'Scanned QR Code: $code',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        ScanQr().CheckAttendance(code, _selectedValue!, context);
        ProgressDialog pd = ProgressDialog(context: context);
        pd.show(
          max: 100,
          msg: 'Scanning...',
          backgroundColor: const Color(0xFF6E738E),
          progressBgColor: Colors.transparent,
          progressValueColor: Colors.blue,
          msgColor: Colors.white,
          valueColor: Colors.white,
        );

        Future.delayed(const Duration(seconds: 3), () {
          pd.close();
        });
      }
    } else {
      print('QR Code is null');
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

}
