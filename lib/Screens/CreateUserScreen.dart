import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Function/VerifyData.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  CreateUserState createState() => CreateUserState();

  const CreateUserScreen({super.key});
}

class CreateUserState extends State<CreateUserScreen> {
  bool  passwordVisibility1 = true;
  bool passwordVisibility2 = true;

  String? _selectedValue; // The selected value for the spinner

  // List of items for the spinner
  final List<String> _items = ['Select a role', 'Admin', 'Teacher'];

  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController firstName= TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();



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
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    // Add 20 pixels of space on the left
                    child: Align(
                      alignment: Alignment(-1.00, 0.0), // Align to the left
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
                    width: 300, // Adjust the width as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the TextField
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple), // Border color
                    ),
                    child: TextField(
                      controller: username,
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
                       controller: email,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
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
                      controller: firstName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'First Name',
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
                      controller: lastName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Last Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(
                      width: 300, // Adjust the width as needed
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of the TextField
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepPurple), // Border color
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true, // Makes the DropdownButton take the full width of its parent
                          value: _selectedValue,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          items: _items.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value ,style: const TextStyle(color: Colors.black,fontFamily: 'Roboto')),
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
                    width: 300, // Adjust the width as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the TextField
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple), // Border color
                    ),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        counterStyle: const TextStyle(color: Colors.black    ,fontFamily: 'Roboto'),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisibility1 ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility1,
                        ),
                      ),
                      obscureText: passwordVisibility1, // To obscure the password input
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
                      controller: confirmPassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confirm Password',
                        counterStyle: const TextStyle(color: Colors.black    ,fontFamily: 'Roboto'),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisibility2 ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility2,
                        ),
                      ),
                      obscureText: passwordVisibility2, // To obscure the password input
                    ),
                  ),
                  const SizedBox(height: 40),
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

                          CheckData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE9ECEF), // Background color of the button
                        ),
                        child: const Text('Add User',
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

  void CheckData(){
    var username = this.username.text;
    var email = this.email.text;
    var firstName = this.firstName.text;
    var lastName = this.lastName.text;
    var password = this.password.text;
    var confirmPassword = this.confirmPassword.text;
    var role = _selectedValue;


    Map <String, dynamic> userData = {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    VerifyDataClass().CheckData2(userData , context, ClearData);

  }

  void ClearData(){
    username.clear();
    email.clear();
    firstName.clear();
    lastName.clear();
    password.clear();
    confirmPassword.clear();
    _selectedValue = _items.isNotEmpty ? _items [0] : null;
  }
}