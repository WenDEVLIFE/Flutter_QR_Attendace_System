import 'package:flutter/material.dart';
import 'QRPage.dart';

class Maincontroller extends StatefulWidget {
  Maincontroller({super.key});
  String username = 'meow';

  @override
  _MaincontrollerState createState() => _MaincontrollerState();
}

class _MaincontrollerState extends State<Maincontroller> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;

  List<Widget> screens = [
    const Qrpage(username: 'meow'),
    const Qrpage(username: 'meow'),
    const Qrpage(username: 'meow'),
    const Qrpage(username: 'meow'),
    const Qrpage(username: 'meow'),
    // Add other screens here
  ];

  void _onItemTapped(int index) {
    if (index == 5) {
      Logout();
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure all items are displayed
        backgroundColor: const Color(0xFF6E738E),
        items: List.generate(6, (index) {
          return BottomNavigationBarItem(
            icon: MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = index),
              onExit: (_) => setState(() => _hoveredIndex = -1),
              child: Icon(
                _getIconForIndex(index),
                color: _hoveredIndex == index ? Colors.blue : (_selectedIndex == index ? Colors.white : Colors.black),
              ),
            ),
            label: _getLabelForIndex(index),
          );
        }),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white, // Color for the selected item
        unselectedItemColor: Colors.black, // Color for the unselected items
        onTap: _onItemTapped,
      ),
    );
  }

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

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'My Qr';
      case 1:
        return 'Profile';
      case 2:
        return 'Scan';
      case 3:
        return 'Attendance Logs';
      case 4:
        return 'User';
      case 5:
        return 'Logout';
      default:
        return 'Home';
    }
  }

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
}