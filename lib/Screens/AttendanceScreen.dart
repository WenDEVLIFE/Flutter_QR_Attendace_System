import 'package:attendance_qr_system/model/AttendanceModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<void> _fetchAttendances() async {
    List<AttendanceModel> attendances = await _retrieveController.fetchAttendances();
    setState(() {
      _attendances = attendances;
      _filteredAttendances = attendances;
      _isLoading = false;
    });
  }

  void _filterAttendances() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAttendances = _attendances.where((attendance) {
        final fullName = '${attendance.firstName} ${attendance.lastName}'.toLowerCase();
        return fullName.contains(query);
      }).toList();
    });
  }

  Future<void> _deleteAttendance(String id) async {
    try {
      await FirebaseFirestore.instance.collection('Attendance').doc(id).delete();
      _showToast('Attendance deleted successfully', Colors.green);
      _fetchAttendances(); // Refresh the list
    } catch (e) {
      print('Error deleting attendance: $e');
      _showToast('Error deleting attendance', Colors.red);
    }
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
                      title: Text(
                        'Name: ${attendance.firstName} ${attendance.lastName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: Text(
                        'Date: ${attendance.date}\nStatus: ${attendance.status}\nTimeIn: ${attendance.timeIn}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAttendance(attendance.id),
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