import 'package:fdmApp/screens/ConnectionCheck.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ConnectionCheck().check();
  runApp(MyApp());
}
