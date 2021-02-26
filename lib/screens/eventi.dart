import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/eventi/eventiBuilder.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:flutter/material.dart';

import 'badConnection.dart';
import 'eventi/infoBuilder.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';

class Eventi extends StatefulWidget {
  static const String routeName = "/eventi";

  @override
  _EventiState createState() => _EventiState();
}

class _EventiState extends State<Eventi> {
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
          "Eventi",
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
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            EventiBuilder(),
            SizedBox(
              height: 35,
            ),
            InfoBuilder(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
