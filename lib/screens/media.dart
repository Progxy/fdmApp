import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/media/videoBuilder.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:flutter/material.dart';

import 'badConnection.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';
import 'media/fotoBuilder.dart';

class Media extends StatefulWidget {
  static const String routeName = "/media";

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {
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
          "Foto e Video",
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
            FotoBuilder(),
            SizedBox(
              height: 35,
            ),
            VideoBuilder(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
