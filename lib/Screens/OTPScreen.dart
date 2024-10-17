import 'dart:async';
import 'package:attendance_qr_system/EmailAPI/YahooAPI.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Component/OTPField.dart'; // Import the OTPField class

class OTPScreen extends StatefulWidget {
  final Map<String, dynamic> extra;

  const OTPScreen({super.key, required this.extra});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _isLoading = false;
  int otp = 0;
  int time = 60;
  Timer? _timer;
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    GenerateOTP();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void GenerateOTP() {
    // Generate a random 6-digit OTP
    int min = 234563;
    int max = 999999;
    otp = min + (DateTime.now().millisecond % (max - min));
    YahooMail().sendEmail(otp, widget.extra['email'], _setLoading, context);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        timer.cancel();
      }
    });
  }

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
            'Enter the OTP',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              print('Back button clicked');
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please enter the OTP sent to your email',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                OTPField(controllers: _controllers), // Pass the controllers to OTPField
                const SizedBox(height: 20),
                Container(
                  width: 300, // Adjust the width as needed
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Background color of the TextField
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.transparent), // Border color
                  ),
                  child: ButtonTheme(
                    minWidth: 300, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    child: ElevatedButton(
                      onPressed: () {
                        print('Entered OTP: $otp');
                        OTPField(controllers: _controllers).OTPVerification(otp, context, widget.extra);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE9ECEF), // Background color of the button
                      ),
                      child: const Text('Verify OTP',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300, // Adjust the width as needed
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Background color of the TextField
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.transparent), // Border color
                  ),
                  child: ButtonTheme(
                    minWidth: 300, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    child: ElevatedButton(
                      onPressed: () {
                        if (time == 0) {
                          GenerateOTP();
                          setState(() {
                            time = 60;
                          });
                          startTimer();
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please wait for the timer to finish',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE9ECEF), // Background color of the button
                      ),
                      child: const Text('Resend OTP',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                  ),
                ),
                Text(
                  'Time left: $time seconds',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void VerifyOTP() {
    if (time == 0) {
      GenerateOTP();
      startTimer();
    } else {
      Fluttertoast.showToast(
          msg: 'Please wait for the timer to finish',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}