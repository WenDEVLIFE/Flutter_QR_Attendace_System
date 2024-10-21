import 'package:attendance_qr_system/DatabaseController/AddEventController.dart';
import 'package:flutter/material.dart';

class CreateEventRoomScreen extends StatefulWidget {
  const CreateEventRoomScreen({super.key});

  @override
  _CreateEVEventState createState() => _CreateEVEventState();
}

class _CreateEVEventState extends State<CreateEventRoomScreen> {
  final TextEditingController _eventname = TextEditingController();
  final TextEditingController _eventlocation = TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventEndDateController = TextEditingController();
  final TextEditingController _endEventTimeController = TextEditingController();

  Future<bool> _onBackPressed() async {
    Navigator.pop(context);
    return false; // Prevent the default back button action
  }

  // Select start time
  Future<void> _selectStartTime(BuildContext context) async {
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

  // Select end time
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _endEventTimeController.text = picked.format(context);
      });
    }
  }

  // Select start date
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _eventDateController.text = picked.toString().substring(0, 10);
      });
    }
  }

  // Select end date
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _eventEndDateController.text = picked.toString().substring(0, 10);
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
                      onTap: () => _selectStartDate(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Start Event Date',
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
                      controller: _eventEndDateController,
                      readOnly: true,
                      onTap: () => _selectEndDate(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'End Event Date',
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
                      onTap: () => _selectStartTime(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Start Event Time',
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
                      controller: _endEventTimeController,
                      readOnly: true,
                      onTap: () => _selectEndTime(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'End Event Time',
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
                      controller: _eventlocation,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Event Location',
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
                          VerifyEvent();
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

  void VerifyEvent() {
    // Add your event verification logic here
    var eventname = _eventname.text;
    var eventlocation = _eventlocation.text;
    var eventTime = _eventTimeController.text;
    var eventDate = _eventDateController.text;
    var eventEndDate = _eventEndDateController.text;
    var endEventTime = _endEventTimeController.text;

    if (eventname.isEmpty || eventlocation.isEmpty || eventTime.isEmpty || eventDate.isEmpty || eventEndDate.isEmpty || endEventTime.isEmpty) {
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 30),
            ),
            content: const Text(
              'Please fill in all the fields',
              style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 18),
            ),
            backgroundColor: const Color(0xFF6E738E),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
              ),
            ],
          );
        },
      );
    } else {
      // Proceed to create the event
      Map data = {
        'eventname': eventname,
        'eventlocation': eventlocation,
        'eventTime': eventTime,
        'eventDate': eventDate,
        'eventEndDate': eventEndDate,
        'endEventTime': endEventTime,
      };
      AddEventController().addEvent(data, ClearFields, context);
    }
  }

  void ClearFields() {
    _eventname.clear();
    _eventlocation.clear();
    _eventTimeController.clear();
    _eventDateController.clear();
    _eventEndDateController.clear();
    _endEventTimeController.clear();
  }
}