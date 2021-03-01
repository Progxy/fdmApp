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

  Future<bool> firstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt('counter') ?? 0;
    if (counter == 0) {
      return true;
    }
    counter++;
    prefs.setInt('counter', counter);
    return false;
  }
}
