import 'package:attendance_qr_system/model/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../DatabaseController/DeleteFirebase.dart';
import '../DatabaseController/RetrieveController.dart'; // Adjust the import path as needed

class Attendancescreen extends StatefulWidget {
  @override
  AttendanceState createState() => AttendanceState();

  const Attendancescreen({super.key});
}

class AttendanceState extends State<Attendancescreen> {
  List<AttendanceModel> _attendances = [];
  List<AttendanceModel> _filteredAttendances = [];
  final TextEditingController _searchController = TextEditingController();
  final RetrieveController _retrieveController = RetrieveController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttendances();
    _searchController.addListener(_filterAttendances);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterAttendances);
    _searchController.dispose();
    super.dispose();
  }

  // This is for fetcing the attendance
  Future<void> _fetchAttendances() async {
    List<AttendanceModel> attendances = await _retrieveController.fetchAttendances();
    setState(() {
      _attendances = attendances;
      _filteredAttendances = attendances;
      _isLoading = false;
    });
  }

  // Filter the attendance
  void _filterAttendances() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAttendances = _attendances.where((attendance) {
        final fullName = attendance.fullname.toLowerCase();
        return fullName.contains(query);
      }).toList();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Logs',
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
        child: Column(
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator( backgroundColor: Colors.white,))
                  : _filteredAttendances.isEmpty
                  ? const Center(child: Text('No attendance found', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')))
                  : ListView.builder(
                itemCount: _filteredAttendances.length,
                itemBuilder: (context, index) {
                  final attendance = _filteredAttendances[index];
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
      ),
    );
  }
}