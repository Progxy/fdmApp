import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/SeCHS.dart';
import 'package:fdmApp/screens/cambioPassword.dart';
import 'package:fdmApp/screens/contatti.dart';
import 'package:fdmApp/screens/eventi.dart';
import 'package:fdmApp/screens/feedback.dart';
import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/home/accountInfo.dart';
import 'package:fdmApp/screens/iscrizione.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:fdmApp/screens/percorsi.dart';
import 'package:fdmApp/screens/privacy.dart';
import 'package:fdmApp/screens/recuperoPassword.dart';
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

  final int subVersion = 1;

  final String beta = "Beta";

  final String name = AccountInfo.name;

  final String email = AccountInfo.email;

  bool isConnected = false;

  void verifyConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
    } else {
      isConnected = true;
    }
  }

  @override
  initState() {
    super.initState();
    verifyConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              if (isConnected) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BadConnection()));
              }
            },
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.person,
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
            title: Text("HomePage", style: TextStyle(fontSize: 23)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            title: Text("Percorsi", style: TextStyle(fontSize: 23)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Percorsi()));
            },
          ),
          ListTile(
              title: Text("Visita Barbiana", style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Visita()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          ListTile(
              title: Text("Eventi", style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Eventi()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          ListTile(
              title: Text("Stampa e Ci Hanno Scritto",
                  style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stampa()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          ListTile(
              title: Text("Foto e Video", style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Media()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
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
              onTap: () {
                if (isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Iscrizione()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          ListTile(
              title:
                  Text("Recupero Credenziali", style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecuperoPassword()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          ListTile(
              title: Text("Cambio Credenziali", style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CambioPassword()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          ListTile(
              title: Text("Feedback", style: TextStyle(fontSize: 23)),
              onTap: () {
                if (isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedBack()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BadConnection()));
                }
              }),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  "Version $beta $version.$subVersion",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
