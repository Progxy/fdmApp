import 'package:firebase_database/firebase_database.dart';

class ContentManager {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  getArticle() async {
    Map result;
    await database.reference().child("Articolo").orderByValue().once().then(
      (DataSnapshot snapshot) {
        final Map map = new Map.from(snapshot.value);
        result = map;
      },
    );
    return result;
  }

  getFoto() async {
    Map result;
    await database.reference().child("Foto").orderByValue().once().then(
      (DataSnapshot snapshot) {
        final Map map = new Map.from(snapshot.value);
        result = map;
      },
    );
    return result;
  }

  getVideo() async {
    Map result;
    await database.reference().child("Video").orderByValue().once().then(
      (DataSnapshot snapshot) {
        final Map map = new Map.from(snapshot.value);
        result = map;
      },
    );
    return result;
  }

  getEvent() async {
    Map result;
    await database.reference().child("Evento").orderByValue().once().then(
      (DataSnapshot snapshot) {
        final Map map = new Map.from(snapshot.value);
        result = map;
      },
    );
    return result;
  }

  getCHS() async {
    Map result;
    await database
        .reference()
        .child("Ci Hanno Scritto")
        .orderByValue()
        .once()
        .then(
      (DataSnapshot snapshot) {
        final Map map = new Map.from(snapshot.value);
        result = map;
      },
    );
    return result;
  }

  getStampa() async {
    Map result;
    await database.reference().child("Stampa").orderByValue().once().then(
      (DataSnapshot snapshot) {
        final Map map = new Map.from(snapshot.value);
        result = map;
      },
    );
    return result;
  }
}
