import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OTPScreen extends StatefulWidget {

  final String email; // Email to which the OTP is sent
  const OTPScreen({super.key, required this.email});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Prevent going back to the main page
      return false;
    },
     child:Scaffold(
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
                context.go('/Signuppage');
              },
            ),
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF6E738E),
          ),
          body:Container(
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return _buildOTPField(index);
                    }),
                  ),
                  SizedBox(height: 20),
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
                          String otp = _controllers.map((controller) => controller.text).join();
                          print('Entered OTP: $otp');
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
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildOTPField(int index) {
    return Container(decoration:
      BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: 40,
      child: TextField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
