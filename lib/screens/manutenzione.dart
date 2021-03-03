import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:flutter/material.dart';

import 'badConnection.dart';
import 'feedback.dart';

class Manutenzione extends StatefulWidget {
  static const String routeName = "/manutenzione";
  @override
  _ManutenzioneState createState() => _ManutenzioneState();
}

class _ManutenzioneState extends State<Manutenzione> {
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
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Manutenzione In Corso",
            style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192),
              fontWeight: FontWeight.w700,
            ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Icon(
                  Icons.error,
                  size: 75.0,
                  color: Colors.red,
                ),
              ),
            ),
            Center(
              child: Text(
                "Manutenzione dell'applicazione in corso, si prega di riprovare più tardi! Ci scusiamo per il disagio,\n\nLa Fondazione Don Milani.",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
