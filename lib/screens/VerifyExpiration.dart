import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class VerifyExpiration {
  changeExpirationState(String id) async {
    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    try {
      secondaryDb.child("Tessere/" + id).update({
        "scaduto": true,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  isAlreadyExpired(String id) async {
    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    bool result;
    try {
      await secondaryDb
          .child("Tessere/" + id + "/scaduto")
          .orderByValue()
          .once()
          .then((DataSnapshot snapshot) {
        result = snapshot.value;
      });
      return result;
    } catch (e) {
      return false;
    }
  }

  verify(FirebaseDatabase database) async {
    DateTime dateExp;
    final firebaseAuthCheck = FirebaseAuth.instance.currentUser;
    if (firebaseAuthCheck == null) {
      return false;
    }
    final DateTime now = DateTime.now();
    String id = "";
    await database
        .reference()
        .child(firebaseAuthCheck.uid)
        .child("Id")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      LinkedHashMap<dynamic, dynamic> values = snapshot.value;
      Map<String, String> map =
          values.map((a, b) => MapEntry(a as String, b as String));
      map.forEach((k, value) => {id = k});
    });
    var resultExpired = await isAlreadyExpired(id);
    if (resultExpired) {
      return true;
    }
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
    if (dateExp.isBefore(now)) {
      await changeExpirationState(id);
      return true;
    } else {
      return false;
    }
  }
}
