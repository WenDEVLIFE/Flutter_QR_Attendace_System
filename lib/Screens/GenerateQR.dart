import 'package:flutter/material.dart';

import '../Function/VerifyData.dart';

class GenerateQr extends StatefulWidget {
  @override
  GenerateQrState createState() => GenerateQrState();

  const GenerateQr({super.key});
}

class GenerateQrState extends State<GenerateQr> {
  bool passwordVisibility1 = true;
  bool passwordVisibility2 = true;

  String? selectedGrade, selectedSection, selectedGender; // The selected value for the spinner
  final List<String> _items = ['Select a grade', 'Grade 11', 'Grade 12'];
  final List<String> _gender = ['Select a gender', 'Male', 'Female'];
  final List<String> _sections = ['Select a section', 'Curiosity', 'Resilience'];

  // TextEditingControllers for each TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedGrade = _items.isNotEmpty ? _items[0] : null; // Auto-select the first item if the list is not empty
    selectedSection = _sections.isNotEmpty ? _sections[0] : null; // Auto-select the first item if the list is not empty
    selectedGender = _gender.isNotEmpty ? _gender[0] : null; // Auto-select the first item if the list is not empty
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
                      child: Text('Generate QR', style: TextStyle(
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
                          'Sign up to generate your QR code',
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
                          value: selectedSection,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          items: _sections.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black, fontFamily: 'Roboto')),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedSection = value;
                            });
                          },
                        ),
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
                          value: selectedGender,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          items: _gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.black, fontFamily: 'Roboto')),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedGender = value;
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
                        child: const Text('Generate QR Code',
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
      'email': email,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'section': selectedSection,
      'grade': selectedGrade,
      'gender': selectedGender,
    };

    var send ="CreateStudent";
   VerifyDataClass().CheckData(UserData, context, send, ClearData);
  }

  void ClearData(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _courseController.clear();
    _items.isNotEmpty ? _items[0] : null;
    _sections.isNotEmpty ? _sections[0] : null;
    _gender.isNotEmpty ? _gender[0] : null;

  }

}