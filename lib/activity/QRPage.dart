import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrpage extends StatelessWidget {
  final String username;
  const Qrpage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back to the main page
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Qr Code',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF5d5d64),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20), // Padding inside the box
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color for the QR container
                    borderRadius: BorderRadius.circular(15), // Border radius for rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4), // Shadow color
                        blurRadius: 10, // How blurry the shadow is
                        spreadRadius: 1, // Spread of the shadow
                        offset: const Offset(0, 8), // Shadow position (x, y)
                      ),
                    ],
                  ),
                  child: QrImageView(
                    data: username, // The data for the QR code
                    version: QrVersions.auto,
                    size: 300.0, // Size of the QR code
                    gapless: false, // Ensures there are no gaps
                    foregroundColor: Colors.black, // QR code color
                    backgroundColor: Colors.white, // Background color to make the QR code visible
                  ),
                ),
                const SizedBox(height: 20), // Space between QR code and button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Background color of the button
                    elevation: 0, // Elevation of the button
                  ),
                  onPressed: showToast, // call the show toast method
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.download_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10), // Space between the icon and the text
                      Text(
                        'Download Qr',
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
      ),
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: "This is a toast message $username",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
