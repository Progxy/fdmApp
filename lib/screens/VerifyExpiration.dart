import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';

class VerifyExpiration {
  DateTime dateExp;

  retriveData(String email, FirebaseDatabase database) async {
    await database
        .reference()
        .child("Date")
        .orderByValue()
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      LinkedHashMap<dynamic, dynamic> values = snapshot.value;
      Map<String, String> map =
          values.map((a, b) => MapEntry(a as String, b as String));
      String expDate =
          map.keys.firstWhere((k) => map[k] == email, orElse: () => null);
      final DateTime date = DateTime.parse(expDate);
      dateExp = date;
    });
  }

  verify(String email, FirebaseDatabase database) async {
    final DateTime now = DateTime.now();
    await retriveData(email, database);
    final databaseReference = database.reference();
    if (dateExp.isBefore(now)) {
      databaseReference.child("Id").remove();
      databaseReference.child("Date").remove();
      databaseReference.child("Pass").remove();
      databaseReference.child("User").remove();
      return true;
    } else {
      return false;
    }
  }
}
