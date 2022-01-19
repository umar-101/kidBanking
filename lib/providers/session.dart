import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<bool> saveSession(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return true;
  }

  static Future<bool> isKeyAvailable(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(value);
  }

  static Future<String?> readSession(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data;
  }

  static Future<bool> removeSession(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return true;
  }

  static Future<bool> cleanAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
