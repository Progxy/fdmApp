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
      List eventi = [];
      List info = [];
      List general = [];
      map.forEach((name, valueList) => name.startsWith(verifyEvent)
          ? eventi.add("{$name : ${valueList.values}}")
          : info.add("{$name : ${valueList.values}}"));
      general.add(eventi);
      general.add(info);
      return general;
    });
  }
}
