import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class VerifyExpiration {
  verify(FirebaseDatabase database) async {
    DateTime dateExp;
    final firebaseAuthCheck = FirebaseAuth.instance.currentUser;
    final DateTime now = DateTime.now();
    await database
        .reference()
        .child(firebaseAuthCheck.uid)
        .child("Date")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      LinkedHashMap<dynamic, dynamic> values = snapshot.value;
      String expDate;
      Map<String, String> map =
          values.map((a, b) => MapEntry(a as String, b as String));
      map.forEach((k, value) => {expDate = k});
      DateFormat inputDateFormat = new DateFormat("dd-MM-yyyy");
      DateFormat outputDateFormat = new DateFormat("yyyy-MM-dd");
      String dates = outputDateFormat.format(inputDateFormat.parse(expDate));
      final DateTime date = DateTime.parse(dates);
      dateExp = date;
    });
    final databaseReference = database.reference();
    if (dateExp.isBefore(now)) {
      //change scaduto to true!
      return true;
    } else {
      return false;
    }
  }
}
