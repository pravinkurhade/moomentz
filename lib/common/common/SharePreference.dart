import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static setValue({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getValue({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
