import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  List resultInfos = [];
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
      List infoData = [];
      List eventoData = [];
      List general = [];
      List generalEventi = [];
      List generalInfo = [];
      map.forEach((name, valueList) =>
          name.startsWith(verifyEvent) ? eventi.add(name) : info.add(name));
      map.forEach((name, valueList) => name.startsWith(verifyEvent)
          ? valueList.forEach(
              (k, val) => (val.forEach((key, v) => (eventoData.add(v)))))
          : valueList.forEach(
              (k, val) => (val.forEach((key, v) => (infoData.add(v))))));
      int r = 0;
      int index = 0;
      for (var i in eventi) {
        List tempor = [];
        tempor.add(i);
        tempor.add(eventoData[r]);
        tempor.add(eventoData[r + 1]);
        tempor.add(eventoData[r + 2]);
        tempor.add(eventoData[r + 3]);
        generalEventi.add(tempor);
        r += 2;
      }
      for (var i in info) {
        List tempor = [];
        tempor.add(i);
        tempor.add(infoData[index]);
        tempor.add(infoData[index + 1]);
        tempor.add(infoData[index + 2]);
        tempor.add(infoData[index + 3]);
        generalInfo.add(tempor);
        index += 2;
      }
      general.add(generalEventi);
      general.add(generalInfo);
      resultInfos = general;
    });
  }

  getContentHomePage(FirebaseDatabase database) async {
    await contentHomePage(database);
    return resultInfos;
  }
}
