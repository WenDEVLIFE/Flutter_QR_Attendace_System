import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InsertStudent {
  InsertStudent({required this.extra});
  Map<String, dynamic> extra;

  void InsertFirebase() async {
    try {

      String hashedPassword = BCrypt.hashpw(extra['password'], BCrypt.gensalt());

      await FirebaseFirestore.instance.collection('Users').add({
        'username': extra['username'],
        'email': extra['email'],
        'firstName': extra['firstName'],
        'lastName': extra['lastName'],
        'course': extra['course'],
        'year': extra['year'],
        'password': hashedPassword,
        "role": "Student"
      });
      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
    }
  }
}