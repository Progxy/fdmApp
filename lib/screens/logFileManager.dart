import 'package:shared_preferences/shared_preferences.dart';

class LogFileManager {
  Future<void> storeData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(data, true);
    return;
  }

  Future<bool> getData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(data) ?? false;
    return result;
  }

  Future<void> removeData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(data);
    return;
  }
}
