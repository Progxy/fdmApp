import 'package:fdmApp/screens/SeCHS.dart';
import 'package:fdmApp/screens/contatti.dart';
import 'package:fdmApp/screens/eventi.dart';
import 'package:fdmApp/screens/feedback.dart';
import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/iscrizione.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:fdmApp/screens/percorsi.dart';
import 'package:fdmApp/screens/privacy.dart';
import 'package:fdmApp/screens/visita.dart';
import 'package:flutter/material.dart';

import '../media.dart';

class MainDrawer extends StatelessWidget {
  final int version = 0;
  final int subVersion = 1;
  final String beta = "Beta";
  final String name = "Login";
  final String email = "me@example.com";

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
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
            title: Text("Home", style: TextStyle(fontSize: 23)),
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Visita()));
              }),
          ListTile(
              title: Text("Eventi", style: TextStyle(fontSize: 23)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Eventi()));
              }),
          ListTile(
              title: Text("Stampa e Ci Hanno Scritto",
                  style: TextStyle(fontSize: 23)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Stampa()));
              }),
          ListTile(
              title: Text("Foto e Video", style: TextStyle(fontSize: 23)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Media()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Iscrizione()));
              }),
          ListTile(
              title: Text("Feedback", style: TextStyle(fontSize: 23)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedBack()));
              }),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 17),
                  child: Text("Version $beta $version.$subVersion",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)))
            ],
          ),
        ],
      ),
    );
  }
}
