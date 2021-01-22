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
      List keys = values.keys;
      final String expDate = keys[0];
      DateFormat inputDateFormat = new DateFormat("dd-MM-yyyy");
      DateFormat outputDateFormat = new DateFormat("yyyy-MM-dd");
      String dates = outputDateFormat.format(inputDateFormat.parse(expDate));
      final DateTime date = DateTime.parse(dates);
      dateExp = date;
    });
    final databaseReference = database.reference();
    if (dateExp.isBefore(now)) {
      databaseReference.child(firebaseAuthCheck.uid).remove();
      return true;
    } else {
      return false;
    }
  }
}
