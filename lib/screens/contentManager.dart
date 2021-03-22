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
}
