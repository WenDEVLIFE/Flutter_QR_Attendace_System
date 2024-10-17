import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventRoomScreen extends StatefulWidget {
  @override
  _CreateEVEventState createState() => _CreateEVEventState();
}

class _CreateEVEventState extends State<CreateEventRoomScreen> {
  final TextEditingController _eventname = TextEditingController();
  final TextEditingController _eventlocation = TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();

  Future<bool> _onBackPressed() async {
    Navigator.pop(context);
    return false; // Prevent the default back button action
  }

  // Select time and date
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _eventTimeController.text = picked.format(context);
      });
    }
  }

  // Select date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _eventDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Event',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              print('Back button clicked');
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Align(
                      alignment: Alignment(-1.00, 0.0),
                      child: Text('Create Event', style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Align(
                      alignment: Alignment(0.0, 0.0),
                      child: Text(
                          'Enter the details below to create an event',
                          style: TextStyle(
                              fontSize: 18, color: Colors.black,
                              fontWeight: FontWeight.w600
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _eventname,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Event Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _eventDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Event Date',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: TextField(
                      controller: _eventTimeController,
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Event Time',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: ButtonTheme(
                      minWidth: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your event/room creation logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE9ECEF),
                        ),
                        child: const Text('Add Event',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}