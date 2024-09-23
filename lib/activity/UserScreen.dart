import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Userscreen extends StatefulWidget {
  @override
  UserState createState() => UserState();
  final VoidCallback GotoCreateUser; // you can pass the function as a parameter to go to next index

  const Userscreen({super.key, required this.GotoCreateUser});
}

class UserState extends State<Userscreen> {
  final List<String> _users = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Hank',
    'Ivy',
    'Jack'
  ];
  List<String> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredUsers = _users;
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        return user.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back to the main page
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Users',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
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
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 400, // Adjust the width as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the TextField
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple), // Border color
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.w600),
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search a user',
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _filteredUsers[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SpeedDial(
                    icon: Icons.edit,
                    activeIcon: Icons.close,
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: const Color(0xFF6E738E),
                    children: [
                      SpeedDialChild(
                        child: const FaIcon(FontAwesomeIcons.userTie, color: Colors.white),
                        backgroundColor: const Color(0xFF6E738E),
                        label: 'Add Admin',
                        onTap: () => widget.GotoCreateUser(),
                      ),
                      SpeedDialChild(
                        child: const FaIcon(FontAwesomeIcons.chalkboardTeacher, color: Colors.white),
                        backgroundColor: const Color(0xFF6E738E),
                        label: 'Add Teacher',
                        onTap: () => widget.GotoCreateUser(),
                      ),
                      SpeedDialChild(
                        child: const FaIcon(FontAwesomeIcons.userGraduate, color: Colors.white),
                        backgroundColor: const Color(0xFF6E738E),
                        label: 'Add Student',
                        onTap: () => widget.GotoCreateUser(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}