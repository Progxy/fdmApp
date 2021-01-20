import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  contentHomePage(FirebaseDatabase database) async {
    await database
        .reference()
        .child("News")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      final String verifyEvent = "Evento";
      Map eventi = {};
      Map info = {};
      List general = [];
      map.forEach((name, valueList) => name.startsWith(verifyEvent)
          ? eventi[name] = valueList.values
          : info[name] = valueList.values);
      print(eventi);
      print(info);
    });
  }
}
