import 'package:attendance_qr_system/Screens/CreateStudentScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../Screens/AttendanceScreen.dart';
import '../Screens/QRPage.dart';
import '../Screens/QrScanner.dart';
import '../Screens/ShowProfile.dart';
import '../Screens/ShowProfile.dart';
import '../Screens/UserScreen.dart';

class Maincontroller extends StatefulWidget {
  Maincontroller({super.key});
  String username = 'meow';
  String role = 'admin'; // Change this to 'admin' to test admin role

  @override
  _MaincontrollerState createState() => _MaincontrollerState();
}

class _MaincontrollerState extends State<Maincontroller> {
  final PageController _pageController = PageController();
  final List<bool> _isHovering = List<bool>.filled(6, false);

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getNavBarItems() {
    List<Widget> items = [];
    if (widget.role == 'admin') {
      items = [
        _buildNavItem(0, Icons.qr_code),
        _buildNavItem(1, Icons.settings),
        _buildNavItem(2, Icons.qr_code_scanner),
        _buildNavItem(3, Icons.document_scanner),
        _buildNavItem(4, Icons.person),
        _buildNavItem(5, FontAwesomeIcons.powerOff),
      ];
    } else {
      items = [
        _buildNavItem(0, Icons.qr_code),
        _buildNavItem(1, Icons.settings),
        _buildNavItem(2, Icons.qr_code_scanner),
        _buildNavItem(3, FontAwesomeIcons.powerOff),
      ];
    }
    return items;
  }

  List<Widget> _getPageViewChildren() {
    List<Widget> pages = [];
    if (widget.role == 'admin') {
      pages = [
        const Qrpage(username: 'meow'),
        Container(), // Placeholder for settings page
        const QrScanner(),
        const Attendancescreen(),
        const Userscreen(),
        const Center(child: Text('Logout Page')), // Placeholder for logout page
      ];
    } else {
      pages = [
        const Qrpage(username: 'meow'),
        Container(), // Placeholder for settings page
        const QrScanner(),
        const Center(child: Text('Logout Page')), // Placeholder for logout page
      ];
    }
    return pages;
  }

  Widget _buildNavItem(int index, IconData icon) {
    return InkWell(
      onHover: (hovering) {
        setState(() {
          _isHovering[index] = hovering;
        });
      },
      child: Icon(
        icon,
        color: _isHovering[index] ? Colors.grey : Colors.white,
        size: 30,
      ),
    );
  }

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
                  _isHovering[index] = false;
                });
              },
              children: _getPageViewChildren(),
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
            items: _getNavBarItems(),
            onTap: (index) {
              if (widget.role == 'admin') {
                if (index == 1) {
                  ShowProfile(context).showProfile();
                  return;
                }
                if (index == 5) {
                  Logout();
                  return;
                } else {
                  _pageController.jumpToPage(index);
                }
              } else {
                if (index == 1) {
                  ShowProfile(context).showProfile();
                  return;
                }
                if (index == 3) {
                  Logout();
                  return;
                } else {
                  _pageController.jumpToPage(index);
                }
              }
            },
          ),
        ],
      ),
    );
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
                context.go('/Loginpage');
              },
              child: const Text('Logout', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
            ),
          ],
        );
      },
    );
  }

}