import 'package:attendance_qr_system/Component/FlutterToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddEventController{
  Future <void> addEvent (Map data, void Function() clearFields, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Creating Event...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );

    try{
      QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection('Events').where('EventName', isEqualTo: data['eventname']).get();
      if (querySnapshot.docs.isEmpty){
        var EventName = data['eventname'];
        var EventDate = data['eventDate'];
        var EventStartTime = data['eventTime'];
        var EventEndTime = data['endEventTime'];
        var EventLocation = data['eventlocation'];
        var EventEndDate = data['eventEndDate'];

        int min = 100000000;
        int max = 999999999;
        int eventID = min + (DateTime.now().millisecondsSinceEpoch % (max - min));

        Map <String, dynamic> event = {
          'EventID': eventID,
          'EventName': EventName,
          'StartDate': EventDate,
          'EndDate': EventEndDate,
          'EventTime': EventStartTime,
          'EndEventTime': EventEndTime,
          'EventLocation': EventLocation,

        };
        await FirebaseFirestore.instance.collection('Events').add(event);
        FlutterToast().showToast('Event added successfully', Colors.green);
        clearFields();

      } else {
        FlutterToast().showToast('Event already exists', Colors.red);
      }
    } catch (e){
      print('Error in addEvent method: $e');
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
        pd.close();
      });
    }
  }

}