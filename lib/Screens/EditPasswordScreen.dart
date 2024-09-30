import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Function/CheckPassword.dart';

class EditPasswordScreen extends StatefulWidget {

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
  const EditPasswordScreen({super.key, required this.username});

  final String username;

}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  bool passwordVisibility1 = true;
  bool passwordVisibility2 = true;
  late String username;

  final TextEditingController oldpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();

  void initState() {
    super.initState();
    username = widget.username;
    Fluttertoast.showToast(
        msg: 'Username: $username',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Future<bool> _onBackPressed() async {
    // Handle the back button press
    Navigator.pop(context);
    return false; // Prevent the default back button action
  }


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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Password',
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
                      child: Text('Change password', style: TextStyle(
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
                          'Enter a new password to change your password',
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
                      controller: oldpassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter your old password',
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
                      controller: newpassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter your new password',
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
                          // Add your onPressed code here!

                          if (oldpassword.text.isEmpty || newpassword.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please fill in all fields',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }

                          else{
                            Map data = {
                              'username': username,
                              'oldpassword': oldpassword.text,
                              'newpassword': newpassword.text
                            };
                            CheckPassword().checkPassword(data,clearData, context);
                          }

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

  void clearData() {
    oldpassword.clear();
    newpassword.clear();
  }
}
