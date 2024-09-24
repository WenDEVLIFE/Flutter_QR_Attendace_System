import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userInfo['username']);
    prefs.setString('role', userInfo['role']);
    prefs.setString('firstname', userInfo['firstname']);
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username')) {
      return {
        'username': prefs.getString('username'),
        'role': prefs.getString('role'),
        'firstname': prefs.getString('firstname'),
      };
    }
    return null;
  }

  Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('role');
    prefs.remove('firstname');
  }
}