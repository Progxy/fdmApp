import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class VerifyExpiration {
  verify(String email, FirebaseDatabase database) async {
    final String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final DateTime now = DateTime.parse(today);
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
      final DateTime dateExp = DateTime.parse(expDate);
      final databaseReference = database.reference();
      if (dateExp.isAfter(now)) {
        databaseReference.child("Id").remove();
        databaseReference.child("Date").remove();
        databaseReference.child("Pass").remove();
        databaseReference.child("User").remove();
        return false;
      } else {
        return true;
      }
    });
  }
}
