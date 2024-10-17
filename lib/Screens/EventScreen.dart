import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../DatabaseController/DeleteFirebase.dart';
import '../DatabaseController/RetrieveController.dart';
import '../model/UserDataModel.dart';

class EventScreen extends StatefulWidget {

  const EventScreen({super.key});

  @override
  EventState createState() => EventState();
}

class EventState extends State<EventScreen> {
  List<UserDataModel> _users = [];
  List<UserDataModel> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  final RetrieveController _retrieveController = RetrieveController();
  bool _isloading = true;
  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  // Filter the user
  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        return user.username.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Fetch the user
  Future<void> _fetchUsers() async {
    List<UserDataModel> users = await _retrieveController.fetchUser();
    setState(() {
      _users = users;
      _filteredUsers = users;
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }


  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
            'Events & Rooms',
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
                        labelText: 'Search a event or room',
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
                    child: _isloading
                        ? const Center(child: CircularProgressIndicator(backgroundColor: Colors.white))
                        : _filteredUsers.isEmpty
                        ? const Center(child: Text('No user found', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')))
                        : ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.person, color: Colors.black, size: 64),
                            title: Text(
                              'Username: ${user.username}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            subtitle: Text(
                              'Status: ${user.status}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                DeleteFirebase().DeleteUser(user.id, _fetchUsers, _showToast, "username");
                              },
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
                        onTap: () {
                          context.push('/CreateUser');
                        },
                      ),
                      SpeedDialChild(
                        child: const FaIcon(FontAwesomeIcons.chalkboardTeacher, color: Colors.white),
                        backgroundColor: const Color(0xFF6E738E),
                        label: 'Add Teacher',
                        onTap: () {
                          context.push('/CreateUser');
                        },
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