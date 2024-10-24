import 'package:attendance_qr_system/model/StudentModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../DatabaseController/DeleteFirebase.dart';
import '../DatabaseController/RetrieveController.dart';
import '../model/UserDataModel.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<StudentModel> student = [];
  List<StudentModel> filteredStudent = [];
  final TextEditingController _searchController = TextEditingController();
  final RetrieveController _retrieveController = RetrieveController();
  bool _isloading = true;
  late String username;

  @override
  void initState() {
    super.initState();
    fetchStudent();
    _searchController.addListener(FilterStudent);
  }

  @override
  void dispose() {
    _searchController.removeListener(FilterStudent);
    _searchController.dispose();
    super.dispose();
  }

  // Filter the user
  void FilterStudent() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredStudent = student.where((studentdata) {
        final students = studentdata.FullName.toLowerCase();
        return students.contains(query);
      }).toList();
    });
  }

  // Fetch the user
  Future<void> fetchStudent() async {
    List<StudentModel> students   = await _retrieveController.fetchStudent();
    setState(() {
      student = students;
      filteredStudent = students;
      _isloading = false;
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
            'Student',
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
                    child: _isloading
                        ? const Center(child: CircularProgressIndicator( backgroundColor: Colors.white,))
                        : filteredStudent.isEmpty
                        ? const Center(child: Text('No attendance found', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')))
                        : ListView.builder(
                      itemCount: filteredStudent.length,
                      itemBuilder: (context, index) {
                        final studentUser = filteredStudent[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.verified_user, color: Colors.black, size: 64),
                            title: Text(
                              'Name: ${studentUser.FullName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender: ${studentUser.Gender}\n Grade: ${studentUser.Gender} \n Section: ${studentUser.Section}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add your button action here
                                    Map <String , dynamic> data = {
                                      'FullName': studentUser.FullName,
                                      'ID': studentUser.studentID,
                                    };

                                    context.push("/ViewStudent", extra: data);
                                  },
                                  icon: const Icon(Icons.remove_red_eye_sharp),
                                  label: const Text('View Student Data'),
                                )
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: (){
                                 DeleteFirebase().DeleteStudent(studentUser.id, fetchStudent);
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
                        child: const FaIcon(FontAwesomeIcons.graduationCap, color: Colors.white),
                        backgroundColor: const Color(0xFF6E738E),
                        label: 'Create Student',
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