import 'package:attendance_qr_system/model/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../DatabaseController/DeleteFirebase.dart';
import '../DatabaseController/RetrieveController.dart';
import '../model/UserDataModel.dart';

class EventAttendanceScreen extends StatefulWidget {
  const EventAttendanceScreen({super.key, required this.data});

  @override
  EventAttendanceState createState() => EventAttendanceState();

  final Map<String, dynamic> data;
}

class EventAttendanceState extends State<EventAttendanceScreen> {
  List<AttendanceModel> _users = [];
  List<AttendanceModel> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  final RetrieveController _retrieveController = RetrieveController();
  bool _isloading = true;
  late String username;
  late String eventName;
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    eventName = data['eventName'];
    _fetchAttendances();
    _searchController.addListener(_filterUsers);
  }

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
        return user.fullname.toLowerCase().contains(query) || user.section.toLowerCase().contains(query) || user.grade.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Fetch the user
  Future<void> _fetchAttendances() async {
    List<AttendanceModel> users = await _retrieveController.fetchSpecifiedUser(eventName);
    setState(() {
      _users = users;
      _filteredUsers = users;
      _isloading = false;
    });
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
          title: Text(
            'Event Name: $eventName',
            style: const TextStyle(
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
                    child: _isloading
                        ? const Center(child: CircularProgressIndicator( backgroundColor: Colors.white,))
                        : _filteredUsers.isEmpty
                        ? const Center(child: Text('No attendance found', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')))
                        : ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        final attendance = _filteredUsers[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.qr_code, color: Colors.black, size: 64),
                            title: Text(
                              'Name: ${attendance.fullname}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${attendance.date}\nStatus: ${attendance.status}\nTime: ${attendance.timeIn} \nGrade: ${attendance.grade}\nSection: ${attendance.section}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add your button action here
                                    Map <String , dynamic> locationData = {
                                      'latitude': attendance.latitude,
                                      'longitude': attendance.longitude,
                                      'userID': attendance.userID,
                                      'Time': attendance.timeIn,
                                      'Date': attendance.date,
                                      'Status': attendance.status,
                                    };
                                    context.push('/Map', extra: locationData);
                                  },
                                  icon: const Icon(Icons.location_on), // Add your desired icon here
                                  label: const Text('View location'),
                                )
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: (){
                                DeleteFirebase().DeleteAttendance(attendance.id, _fetchAttendances(), _showToast);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}