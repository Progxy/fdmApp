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
        title: Text("Stampa e Ci Hanno Scritto"),
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
