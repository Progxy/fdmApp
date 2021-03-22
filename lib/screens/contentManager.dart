import 'package:firebase_database/firebase_database.dart';

class ContentManager {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  getArticle() async {
    await database.reference().child("Articolo").orderByValue().once().then(
      (DataSnapshot snapshot) {
        Map map = new Map.from(snapshot.value);
        print("article map : $map");
      },
    );
  }
}
