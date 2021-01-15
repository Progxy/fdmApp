import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdmApp/screens/ConnectionCheck.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';

bool useFirestoreEmulator = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (useFirestoreEmulator) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  await ConnectionCheck().check();
  runApp(MyApp());
}
