import 'package:attendance_qr_system/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Function/VerifyData.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordVisibility1 = true;
  bool passwordVisibility2 = true;

  String? selectedGrade, selectedSection; // The selected value for the spinner
  final List<String> _items = ['Select a grade', 'Grade 11', 'Grade 12'];
  final List<String>  _sections = ['Select a section', 'Curiosity', 'Resilience'];

  // TextEditingControllers for each TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _togglePasswordVisibility1() {
    setState(() {
      passwordVisibility1 = !passwordVisibility1;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      passwordVisibility2 = !passwordVisibility2;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedGrade = _items.isNotEmpty ? _items[0] : null; // Auto-select the first item if the list is not empty
  }

  Future<bool> _onBackPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    return false; // Prevent the default back button action
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Align(
                      alignment: Alignment(-1.00, 0.0),
                      child: Text('Create Account', style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Align(
                      alignment: Alignment(0.0, 0.0),
                      child: Text(
                          'Sign up to create an account',
                          style: TextStyle(
                              fontSize: 18, color: Colors.black,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
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
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'First Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Last Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _courseController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Course',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedGrade,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          items: _items.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black, fontFamily: 'Roboto')),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedGrade = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: ButtonTheme(
                      minWidth: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          VerifyData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE9ECEF),
                        ),
                        child: const Text('Sign up',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: const Alignment(0.0, 0.0),
                      child: GestureDetector(
                        onTap: () {
                          context.go('/Loginpage');
                        },
                        child: const Text(
                          'Already have an account? Sign in here',
                          style: TextStyle(
                              fontSize: 18, color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  // This will check if the data is valid
  void VerifyData() {
    // Get the values from the TextFields
    final email = _emailController.text;
    final Map<String, dynamic> UserData = {
      'username': _usernameController.text,
      'email': email,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'course': _courseController.text,
      'year': selectedGrade,
      'password': _passwordController.text,
      'confirmPassword': _confirmPasswordController.text,
    };

    var send ="OTP";
    VerifyDataClass().CheckData(UserData,context,send,clearData);
  }

  void clearData() {
    _usernameController.clear();
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _courseController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}