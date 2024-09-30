import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.username});
  final String username;

  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfileScreen> {

  late String username;

  void initState() {
    super.initState();
    username = widget.username;
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
            'Change Profile',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 95,
                          backgroundImage: AssetImage('Assets/fufu.jpg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Add your camera function here
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your update profile logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE9ECEF),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
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
}
