import 'package:attendance_qr_system/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordVisibility1 = true;
  bool passwordVisibility2 = true;

  String? _selectedValue; // The selected value for the spinner
  final List<String> _items = ['Select a year', '1st year', '2nd year', '3rd year', '4th year'];

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
    _selectedValue = _items.isNotEmpty ? _items[0] : null; // Auto-select the first item if the list is not empty
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
                          value: _selectedValue,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          items: _items.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black, fontFamily: 'Roboto')),
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
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
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
                            passwordVisibility1 ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility1,
                        ),
                      ),
                      obscureText: passwordVisibility1,
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
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confirm Password',
                        counterStyle: const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisibility2 ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility2,
                        ),
                      ),
                      obscureText: passwordVisibility2,
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
  void VerifyData(){
    // Get the values from the TextFields
    final email = _emailController.text;

    // Email pattern or regex
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');


    if (_usernameController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Username is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_emailController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Email is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_firstNameController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "First name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_lastNameController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Last name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_courseController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Course is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (_selectedValue == _items[0]) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Please select a year",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_passwordController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_confirmPasswordController.text.isEmpty) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Confirm password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Passwords do not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    }

    else if (_emailController.text.isEmpty) {
      // Validate the email address
      Fluttertoast.showToast(
        msg: "Email is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    }

    else if (!emailPattern.hasMatch(email)) {
      // Show an error message
      Fluttertoast.showToast(
        msg: "Invalid email address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    }

    else {
      // Proceed to the next screen
      context.push('/Otp', extra: {
        'username': _usernameController.text,
        'email': _emailController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'course': _courseController.text,
        'year': _selectedValue,
        'password': _passwordController.text,
      });
    }
  }
}