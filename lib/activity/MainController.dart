import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'QRPage.dart';

class Maincontroller extends StatefulWidget {
  Maincontroller({super.key});
  String username = 'meow';

  @override
  _MaincontrollerState createState() => _MaincontrollerState();
}

class _MaincontrollerState extends State<Maincontroller> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const Qrpage(username: 'meow'),
    Container(),
    const Qrpage(username: 'meow'),
    const Qrpage(username: 'meow'),
    const Qrpage(username: 'meow'),
    Container(),
    // Add other screens here
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      ShowProfile();
      return;
    }
    if (index == 5) {
      Logout();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // Reset the scale after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
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
              return Icon(
                _getIconForIndex(index),
                color: _selectedIndex == index ? Colors.white : Colors.black,
              );
            }),
            index: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }

  // This is for icon data method
  IconData _getIconForIndex(int index) {
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
        return Icons.logout;
      default:
        return Icons.home;
    }
  }

  // Used for logout function
  void Logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto' ,
                  fontSize: 30)),
          content: const Text('Are you sure you want to logout?',
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18)),
          backgroundColor: const Color(0xFF6E738E),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.white, fontFamily: 'Roboto' )),
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

  // This will show Profile
  void ShowProfile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Container(
              height: 200,
              color: const Color(0xFF6E738E),
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
                        child:GestureDetector(
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
                ],
              ),
            ),
        );
      },
    );
  }
}