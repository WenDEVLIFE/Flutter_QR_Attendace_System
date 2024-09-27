import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../Function/SessionManager.dart';
import '../Screens/AttendanceScreen.dart';
import '../Screens/QRPage.dart';
import '../Screens/QrScanner.dart';
import '../Screens/ShowProfile.dart';
import '../Screens/UserScreen.dart';

class Maincontroller extends StatefulWidget {
  const Maincontroller({super.key, required this.userInfo});
  final Map<String, dynamic> userInfo;

  @override
  _MaincontrollerState createState() => _MaincontrollerState();
}

class _MaincontrollerState extends State<Maincontroller> {
  final PageController _pageController = PageController(initialPage: 1); // Set initial page to index 1
  final List<bool> _isHovering = List<bool>.filled(6, false);
  final SessionManager sessionManager = SessionManager();
  late String username;
  late String role;
  late String firstName;
  int _currentIndex = 1; // Initialize to index 1

  @override
  void initState() {
    super.initState();
    role = widget.userInfo['role'];
    username = widget.userInfo['username'];
    firstName = widget.userInfo['firstname'];

    // Automatically select index 1 on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
      if (role == 'Admin') {
        _pageController.jumpToPage(1);
      } else {
        _pageController.jumpToPage(0);
      }
      });
    });
  }

  List<Widget> _getNavBarItems() {
    List<Widget> items = [];
    if (role == 'Admin') {
      items = [
        _buildNavItem(0, Icons.settings),
        _buildNavItem(1, Icons.document_scanner),
        _buildNavItem(2, Icons.person),
        _buildNavItem(3, FontAwesomeIcons.powerOff),
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
    if (role == 'Admin') {
      pages = [
        Container(), // Placeholder for settings page
        const Attendancescreen(), // Automatically select this for Admin
        const Userscreen(),
        Container(), // Placeholder for settings page
      ];
    } else {
      pages = [
        Qrpage(username: username, firstname: firstName),
        Container(), // Automatically select this for Student
        const QrScanner(),
        Container(), // Placeholder for settings page
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
                  _currentIndex = index; // Track current index
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
            index: _currentIndex, // Set the initial index
            onTap: (index) {
              setState(() {
                _currentIndex = index; // Update current index on tap
              });

              if (role == 'Admin') {
                if (index == 0) {
                  ShowProfile(context).showProfile(username: username, firstname: firstName, role: role);
                  return;
                }
                if (index == 3) {
                  Logout();
                  return;
                } else {
                  _pageController.jumpToPage(index);
                }
              } else {
                if (index == 1) {
                  ShowProfile(context).showProfile(username: username, firstname: firstName, role: role);
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
                sessionManager.clearUserInfo();
              },
              child: const Text('Logout', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
            ),
          ],
        );
      },
    );
  }
}
