import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  List resultDisponibilita = [];
  List resultIndisponibilita = [];

  contentDisponibilita(FirebaseDatabase database) async {
    await database
        .reference()
        .child("Disponibilita")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      List generalDate = [];
      List generalVolontari = [];
      List general = [];
      map.forEach((name, valueList) => generalDate.add(name));
      map.forEach((name, valueList) => valueList.forEach((k, val) =>
          (val.forEach((key, value) => (generalVolontari.add(value))))));
      int index = 0;
      for (var i in generalDate) {
        List tempor = [];
        tempor.add(i);
        tempor.add(generalVolontari[index]);
        general.add(tempor);
        index += 1;
      }
      resultDisponibilita = general;
    });
  }

  getDisponibilita(FirebaseDatabase database) async {
    await contentDisponibilita(database);
    return resultDisponibilita;
  }

  contentIndisponibilita(FirebaseDatabase database) async {
    await database
        .reference()
        .child("Indisponibilita")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      List generalDate = [];
      List generalVolontari = [];
      List general = [];
      map.forEach((name, valueList) => generalDate.add(name));
      map.forEach((name, valueList) =>
          valueList.forEach((k, val) => (generalVolontari.add(val))));
      int index = 0;
      for (var i in generalDate) {
        List tempor = [];
        tempor.add(i);
        tempor.add(generalVolontari[index]);
        general.add(tempor);
        index += 1;
      }
      resultIndisponibilita = general;
    });
  }

  getIndisponibilita(FirebaseDatabase database) async {
    await contentIndisponibilita(database);
    return resultIndisponibilita;
  }
}
