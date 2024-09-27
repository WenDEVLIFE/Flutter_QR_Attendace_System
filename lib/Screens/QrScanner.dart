import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  QrState createState() => QrState();
}

class QrState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? _selectedValue; // The selected value for the spinner

  // List of items for the spinner
  final List<String> _items = ['Select to attendance','Time in', 'Time out'];

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = _items.isNotEmpty ? _items[0] : null; // Auto-select the first item if the list is not empty
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
              flex: 6, // Takes 5/6 of the screen height
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.blue,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300, // The size of the scan area
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  width: 300, // Adjust the width as needed
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the TextField
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent), // Border color
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true, // Makes the DropdownButton take the full width of its parent
                      value: _selectedValue,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // dropdownColor: const Color(0xFF6E738E), // Background color of the dropdown
                      items: _items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 20, textBaseline: TextBaseline.alphabetic)),
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
                  backgroundColor: Colors.transparent, // Background color of the button
                  elevation: 0, // Elevation of the button
                ),
                onPressed: () {
                  // Add your upload QR functionality here
                  print('Upload QR');
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
                    SizedBox(width: 10), // Space between the icon and the text
                    Text(
                      'Upload QR',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 10,
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
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