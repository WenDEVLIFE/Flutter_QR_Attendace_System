import 'package:attendance_qr_system/Screens/CreateStudentScreen.dart';
import 'package:attendance_qr_system/Screens/CreateUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Screens/AttendanceScreen.dart';
import '../Screens/QRPage.dart';
import '../Screens/QrScanner.dart';
import '../Screens/UserScreen.dart';

class Maincontroller extends StatefulWidget {
  Maincontroller({super.key});
  String username = 'meow';

  @override
  _MaincontrollerState createState() => _MaincontrollerState();
}

class _MaincontrollerState extends State<Maincontroller> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<bool> _isHovering = List<bool>.filled(6, false);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                const Qrpage(username: 'meow'),
                Container(), // Placeholder for settings page
                const QrScanner(),
                const Attendancescreen(),
                const Userscreen(),
                const Center(child: Text('Logout Page')), // Placeholder for logout page
                const CreateUserScreen(),
                const CreateStudentScreen(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'Assets/bg1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: const Color(0xFF6E738E),
            items: List.generate(6, (index) {
              return MouseRegion(
                onEnter: (_) => _onHover(index, true),
                onExit: (_) => _onHover(index, false),
                child: Icon(
                  _getIcon(index),
                  color: _isHovering[index] ? Colors.grey : Colors.white,
                ),
              );
            }),
            onTap: (index) {
              if (index == 1) {
                ShowProfile();
              }
              if (index == 5) {
                Logout();
              } else {
                _pageController.jumpToPage(index);
              }
            },
          ),
        ],
      ),
    );
  }

  void _onHover(int index, bool hovering) {
    setState(() {
      _isHovering[index] = hovering;
    });
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.qr_code;
      case 1:
        return Icons.settings;
      case 2:
        return Icons.qr_code_scanner;
      case 3:
        return Icons.document_scanner;
      case 4:
        return Icons.person;
      case 5:
        return FontAwesomeIcons.powerOff;
      default:
        return Icons.help;
    }
  }

  void Logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Logout',
            style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 30),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 18),
          ),
          backgroundColor: const Color(0xFF6E738E),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context); // Perform the logout
              },
              child: const Text('Logout', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
            ),
          ],
        );
      },
    );
  }

  void ShowProfile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF6E738E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 250),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close the modal bottom sheet
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 45,
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
                    const SizedBox(width: 10),
                    const Text(
                      'Username: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20, width: 50),
                Row(
                  children: [
                    Container(
                      width: 200, // Adjust the width as needed
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Background color of the TextField
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.transparent), // Border color
                      ),
                      child: ButtonTheme(
                        minWidth: 100, // Adjust the width as needed
                        height: 100, // Adjust the height as needed
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Maincontroller(), // Use Maincontroller, not Maincon
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE9ECEF), // Background color of the button
                          ),
                          child: const Text('Change Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: 'Roboto')),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200, // Adjust the width as needed
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Background color of the TextField
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.transparent), // Border color
                      ),
                      child: ButtonTheme(
                        minWidth: 100, // Adjust the width as needed
                        height: 100, // Adjust the height as needed
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE9ECEF), // Background color of the button
                          ),
                          child: const Text('Change Email',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: 'Roboto')),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10, height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}