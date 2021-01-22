import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../authentication_service.dart';
import 'IscrizioneScaduta.dart';
import 'VerifyExpiration.dart';
import 'home/accountInfo.dart';

class LoadUsername {
  getUser(context, FirebaseDatabase database) async {
    final firebaseAuthCheck = FirebaseAuth.instance.currentUser;
    final bool isExpired = await VerifyExpiration().verify(database);
    if (isExpired) {
      context.read<AuthenticationService>().signOut();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => IscrizioneScaduta()));
    } else {
      if (firebaseAuthCheck != null) {
        await database
            .reference()
            .child(firebaseAuthCheck.uid)
            .child("User")
            .orderByValue()
            .once()
            .then((DataSnapshot snapshot) {
          LinkedHashMap<dynamic, dynamic> values = snapshot.value;
          List keys = values.keys;
          final String username = keys[0];
          List value = values.keys;
          final String email = value[0];
          AccountInfo().setter(username, email);
        });
      }
    }
  }
}
