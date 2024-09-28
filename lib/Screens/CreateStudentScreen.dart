import 'package:attendance_qr_system/DatabaseController/InsertStudent.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Function/VerifyData.dart';

class CreateStudentScreen extends StatefulWidget {
  @override
  StudentState createState() => StudentState();

  const CreateStudentScreen({super.key});
}

class StudentState extends State<CreateStudentScreen> {
  bool  passwordVisibility1 = true;
  bool passwordVisibility2 = true;

  String? _selectedValue; // The selected value for the spinner

  // List of items for the spinner
  final List<String> _items = ['Select a year', '1st year', '2nd year', '3rd year', '4th year'];

  // TextEditingControllers for each TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Function to toggle the password show status
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

  // This will auto select the drop down value
  @override
  void initState() {
    super.initState();
    _selectedValue = _items.isNotEmpty ? _items [0] : null; // Auto-select the first item if the list is not empty
  }

  Future<bool> _onBackPressed() async {
    // Handle the back button press
    Navigator.pop(context);
    return false; // Prevent the default back button action
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create User',
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    // Add 20 pixels of space on the left
                    child: Align(
                      alignment: Alignment(-1.00, 0.0), // Align to the left
                      child: Text('Create Student Account', style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    // Add 20 pixels of space on the left
                    child: Align(
                      alignment: Alignment(0.0, 0.0), // Center align
                      child: Text(
                          'Enter user details to create an account            ',
                          style: TextStyle(
                              fontSize: 18, color: Colors.black,
                              fontWeight: FontWeight.w600
                          )),
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
                        child: const Text('Add Student',
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
      'year': _selectedValue,
      'password': _passwordController.text,
      'confirmPassword': _confirmPasswordController.text,
    };

    var send ="CreateStudent";
   VerifyDataClass().CheckData(UserData, context, send);
  }

}