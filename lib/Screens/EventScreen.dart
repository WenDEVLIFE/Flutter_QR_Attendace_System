import 'package:attendance_qr_system/Component/FlutterToast.dart';
import 'package:attendance_qr_system/model/EventModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../DatabaseController/DeleteFirebase.dart';
import '../DatabaseController/RetrieveController.dart';

class EventScreen extends StatefulWidget {

  const EventScreen({super.key});

  @override
  EventState createState() => EventState();
}

class EventState extends State<EventScreen> {
  List<EventModel> events = [];
  List<EventModel> filteredEvents = [];
  final TextEditingController _searchController = TextEditingController();
  final RetrieveController _retrieveController = RetrieveController();
  bool _isloading = true;
  @override
  void dispose() {
    _searchController.removeListener(filterEvent);
    _searchController.dispose();
    super.dispose();
  }

  // Filter the user
  void filterEvent() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEvents = events.where((event) {
        final eventData = event.eventName.toLowerCase();
        return eventData.contains(query);
      }).toList();
    });
  }

  // Fetch the user
  Future<void> fetchEvents() async {
    List<EventModel> eventdata = await _retrieveController.fetchEvent();
    setState(() {
      events = eventdata;
       filteredEvents= eventdata;
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
    _searchController.addListener(filterEvent);
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
                        : filteredEvents.isEmpty
                        ? const Center(child: Text('No event found', style: TextStyle(color: Colors.white, fontFamily: 'Roboto')))
                        : ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.event_sharp, color: Colors.black, size: 64),
                            title: Text(
                              'Event Name: ${event.eventName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${event.eventDate}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  'Time: ${event.eventTime}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  'Location: ${event.eventLocation}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add your button action here
                                    FlutterToast().showToast('View Event', Colors.green);
                                    Map <String, dynamic> eventData = {
                                      'eventName': event.eventName,
                                      'eventDate': event.eventDate,
                                      'eventTime': event.eventTime,
                                      'eventLocation': event.eventLocation,
                                      'eventID': event.id,
                                    };
                                    context.push('/GoToEvent', extra: eventData);
                                  },
                                  icon: const Icon(Icons.remove_red_eye_sharp), // Add your desired icon here
                                  label: const Text('View Event'),
                                )
                              ],
                            ),

                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ShowDialog(event.id);
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
                        child: const Icon(Icons.add, color: Colors.white),
                        backgroundColor: const Color(0xFF6E738E),
                        label: 'Add Event/Room',
                        onTap: () {
                          context.push('/CreateEventRoom');
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

  void ShowDialog(String id){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Delete Event', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF6E738E),
        content: const Text('Are you sure you want to delete this event?' , style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w600)),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('No' , style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w600),)),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            DeleteFirebase().DeleteEvent(id, fetchEvents);
          }, child: const Text('Yes' , style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w600),)),
        ],
      );
    });
  }
}