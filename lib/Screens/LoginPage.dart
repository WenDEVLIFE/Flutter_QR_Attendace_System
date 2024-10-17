import 'package:attendance_qr_system/DatabaseController/LoginVerification.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 40.0), // Add 20 pixels of space on the left
                  child: Align(
                    alignment: Alignment(-1.00, 0.0), // Align to the left
                    child: Text('Sign In', style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF212529),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0), // Add 20 pixels of space on the left
                  child: Align(
                    alignment: Alignment(0.0, 0.0), // Center align
                    child: Text('Sign in to proceed on scanning attendance', style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF212529),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300, // Adjust the width as needed
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the TextField
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple), // Border color
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Username',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300, // Adjust the width as needed
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the TextField
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple), // Border color
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      counterStyle: const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    obscureText: _obscureText, // To obscure the password input
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
                        // call the controller
                        LoginVerification().Login(username: _usernameController.text, password: _passwordController.text, context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE9ECEF), // Background color of the button
                      ),
                      child: const Text('Sign In',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0), // Add 20 pixels of space on the left
                  child: Align(
                    alignment: const Alignment(0.0, 0.0), // Center align
                    child: GestureDetector(
                      onTap: () {
                        // Add your onTap function here
                        print('Sign up text clicked');
                        // Go to the main page
                        context.push('/Signuppage');
                      },
                      child: const Text(
                        'For students, click me to generate your QR code',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
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

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}