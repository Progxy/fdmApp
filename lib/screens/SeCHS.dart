import 'package:fdmApp/screens/SeCHS/stampaBuilder.dart';
import 'package:flutter/material.dart';
import 'SeCHS/CHSBuilder.dart';
import 'home/mainDrawer.dart';

class Stampa extends StatelessWidget {
  static const String routeName = "/stampa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Stampa e Ci Hanno Scritto",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              size: 30,
            ),
            onPressed: () {
              print("ciò");
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          StampaBuilder(),
          SizedBox(
            height: 35,
          ),
          CHSBuilder(),
        ],
      ),
    );
  }
}
