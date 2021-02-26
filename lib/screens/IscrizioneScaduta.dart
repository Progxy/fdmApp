import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/rinnova.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:flutter/material.dart';

import 'badConnection.dart';
import 'feedback.dart';

class IscrizioneScaduta extends StatefulWidget {
  static const String routeName = "/iscrizionescaduta";

  @override
  _IscrizioneScadutaState createState() => _IscrizioneScadutaState();
}

class _IscrizioneScadutaState extends State<IscrizioneScaduta> {
  final List<String> choices = <String>[
    "FeedBack",
    "Aiuto",
  ];

  void choiceAction(String choice) async {
    if (choice == "Aiuto") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Utilizzo()));
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BadConnection()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedBack()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Iscrizione Scaduta",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList();
            },
          )
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.error,
              color: Colors.red,
              size: 85,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Siamo spiacenti, l'iscrizione a socio del seguente account è scaduta!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 60,
              minWidth: 200,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 24, 37, 102),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 60,
              minWidth: 200,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Rinnova()));
                },
                child: Text(
                  "Rinnova",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 24, 37, 102),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Image(
              image: AssetImage("assets/images/don_milani.png"),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
