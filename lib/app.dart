import 'package:fdmApp/screens/SeCHS.dart';
import 'package:fdmApp/screens/SeCHS/InfoSeCHS.dart';
import 'package:fdmApp/screens/contatti.dart';
import 'package:fdmApp/screens/eventi.dart';
import 'package:fdmApp/screens/eventi/InfoEvento.dart';
import 'package:fdmApp/screens/feedback.dart';
import 'package:fdmApp/screens/iscrizione.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:fdmApp/screens/media.dart';
import 'package:fdmApp/screens/percorsi.dart';
import 'package:fdmApp/screens/percorsi/infoPercorso.dart';
import 'package:fdmApp/screens/privacy.dart';
import 'package:fdmApp/screens/visita.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/visita/disponibilità.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FdmApp',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        routes: {
          MyHomePage.routeName: (context) => MyHomePage(),
          Percorsi.routeName: (context) => Percorsi(),
          Visita.routeName: (context) => Visita(),
          Eventi.routeName: (context) => Eventi(),
          Stampa.routeName: (context) => Stampa(),
          Media.routeName: (context) => Media(),
          Contatti.routeName: (context) => Contatti(),
          Privacy.routeName: (context) => Privacy(),
          Iscrizione.routeName: (context) => Iscrizione(),
          FeedBack.routeName: (context) => FeedBack(),
          Login.routeName: (context) => Login(),
          InfoPercorso.routeName: (context) => InfoPercorso(),
          Disponibilita.routeName: (context) => Disponibilita(),
          InfoEvento.routeName: (context) => InfoEvento(),
          InfoSeCHS.routeName: (context) => InfoSeCHS(),
        });
  }
}
