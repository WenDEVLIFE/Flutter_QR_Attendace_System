import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrpage extends StatelessWidget {
  final String username;
  final String firstname;
  const Qrpage({super.key, required this.username, required this.firstname});

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
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the start of the column
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Aligns items to the start of the column
                  children: [
                    Text(
                      '  ${_getGreeting()}, $firstname',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Here is your Qr Code', // Welcome text
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize:25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10), // Space between the greeting and the username
                  ],
                )
              ),
              Expanded(
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

  // Method to get the appropriate greeting based on the current time
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
