import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Benvenuto"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          "Benvenuto!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
