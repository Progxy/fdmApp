import 'package:fdmApp/authentication_service.dart';
import 'package:fdmApp/screens/SeCHS.dart';
import 'package:fdmApp/screens/SeCHS/InfoSeCHS.dart';
import 'package:fdmApp/screens/badConnection.dart';
import 'package:fdmApp/screens/cambioPassword.dart';
import 'package:fdmApp/screens/contatti.dart';
import 'package:fdmApp/screens/eventi.dart';
import 'package:fdmApp/screens/eventi/InfoEvento.dart';
import 'package:fdmApp/screens/feedback.dart';
import 'package:fdmApp/screens/iscrizione.dart';
import 'package:fdmApp/screens/iscrizione/iscrizione2.dart';
import 'package:fdmApp/screens/iscrizione/iscrizione3.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:fdmApp/screens/login/userpage.dart';
import 'package:fdmApp/screens/media.dart';
import 'package:fdmApp/screens/media/detailedPhoto.dart';
import 'package:fdmApp/screens/media/detailedVideo.dart';
import 'package:fdmApp/screens/percorsi.dart';
import 'package:fdmApp/screens/percorsi/infoPercorso.dart';
import 'package:fdmApp/screens/privacy.dart';
import 'package:fdmApp/screens/recuperoPassword.dart';
import 'package:fdmApp/screens/visita.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/visita/disponibilità.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'FdmApp',
        theme: ThemeData(
          fontFamily: "PlayfairDisplay",
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
          DetailedPhoto.routeName: (context) => DetailedPhoto(),
          DetailedVideo.routeName: (context) => DetailedVideo(),
          UserPage.routeName: (context) => UserPage(),
          PayIscrizione.routeName: (context) => PayIscrizione(),
          ResultIscrizione.routeName: (context) => ResultIscrizione(),
          RecuperoPassword.routeName: (context) => RecuperoPassword(),
          CambioPassword.routeName: (context) => CambioPassword(),
          BadConnection.routeName: (context) => BadConnection(),
        },
      ),
    );
  }
}
