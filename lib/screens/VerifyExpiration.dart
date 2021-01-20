import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class VerifyExpiration {
  verify(String email, FirebaseDatabase database) async {
    DateTime dateExp;
    final DateTime now = DateTime.now();
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
      DateFormat inputDateFormat = new DateFormat("dd-MM-yyyy");
      DateFormat outputDateFormat = new DateFormat("yyyy-MM-dd");
      String dates = outputDateFormat.format(inputDateFormat.parse(expDate));
      final DateTime date = DateTime.parse(dates);
      dateExp = date;
    });
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
