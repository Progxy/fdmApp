import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/SeCHS.dart';
import 'package:fdmApp/screens/cambioPassword.dart';
import 'package:fdmApp/screens/contatti.dart';
import 'package:fdmApp/screens/disdici.dart';
import 'package:fdmApp/screens/eventi.dart';
import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/home/accountInfo.dart';
import 'package:fdmApp/screens/iscrizione.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:fdmApp/screens/percorsi.dart';
import 'package:fdmApp/screens/privacy.dart';
import 'package:fdmApp/screens/recuperoPassword.dart';
import 'package:fdmApp/screens/rinnova.dart';
import 'package:fdmApp/screens/visita.dart';
import 'package:flutter/material.dart';

import '../badConnection.dart';
import '../media.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final int version = 0;

  final int subVersion = 2;

  final String typeVersion = "Alfa";

  final String name = AccountInfo.name;

  final String email = AccountInfo.email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: Image(
                  image: AssetImage("assets/images/don_milani.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
            ),
            InkWell(
              onTap: () async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.none) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }
              },
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 24, 37, 102),
                      child: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 192, 192, 192),
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 8, top: 3),
                        child: Text(
                          "$name",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30, left: 8),
                        child: Text(
                          "$email",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text("Home", style: TextStyle(fontSize: 23)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
            ListTile(
              title: Text("Percorsi", style: TextStyle(fontSize: 23)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Percorsi()));
              },
            ),
            ListTile(
                title: Text("Visita Barbiana", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Visita()));
                  }
                }),
            ListTile(
                title: Text("Disdici Visita", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Disdici()));
                  }
                }),
            ListTile(
                title: Text("Eventi", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Eventi()));
                  }
                }),
            ListTile(
                title: Text("Stampa e Ci Hanno Scritto",
                    style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Stampa()));
                  }
                }),
            ListTile(
                title: Text("Foto e Video", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Media()));
                  }
                }),
            ListTile(
                title: Text("Contatti", style: TextStyle(fontSize: 23)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Contatti()));
                }),
            ListTile(
                title: Text("Privacy", style: TextStyle(fontSize: 23)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Privacy()));
                }),
            ListTile(
                title: Text("Diventa Socio", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Iscrizione()));
                  }
                }),
            ListTile(
                title:
                    Text("Rinnova Iscrizione", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Rinnova()));
                  }
                }),
            ListTile(
                title: Text("Recupero Credenziali",
                    style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecuperoPassword()));
                  }
                }),
            ListTile(
                title: Text("Cambio Password", style: TextStyle(fontSize: 23)),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadConnection()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CambioPassword()));
                  }
                }),
            Divider(
              thickness: 1,
              color: Color.fromARGB(255, 24, 37, 102),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 17),
                  child: Text(
                    "Versione $typeVersion $version.$subVersion",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
