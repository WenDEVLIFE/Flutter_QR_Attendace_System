
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel{

  final String id;

  final int eventID;

  final String eventName;

  final String eventDate;

  final String eventTime;

  final String eventLocation;

  EventModel({
    required this.id,
    required this.eventID,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
  });

  factory EventModel.fromDocument(DocumentSnapshot doc){
    return EventModel(
      id: doc.id,
      eventID: doc['EventID'],
      eventName: doc['EventName'],
      eventDate: doc['StartDate'],
      eventTime: doc['EventTime'],
      eventLocation: doc['EventLocation'],
    );
  }

}