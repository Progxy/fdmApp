import 'package:fdmApp/screens/home/mainBarbiana.dart';
import 'package:fdmApp/screens/home/mainNews.dart';
import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class MyHomePage extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fondazione Don Milani App"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/don_milani.png"),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 20),
                  child: MainNews(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 20),
                  child: MainBarbiana(),
                ),
              ],
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
