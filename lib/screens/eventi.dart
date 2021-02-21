import 'package:fdmApp/screens/eventi/eventiBuilder.dart';
import 'package:flutter/material.dart';

import 'eventi/infoBuilder.dart';
import 'home/mainDrawer.dart';

class Eventi extends StatelessWidget {
  static const String routeName = "/eventi";
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
          EventiBuilder(),
          SizedBox(
            height: 35,
          ),
          InfoBuilder(),
        ],
      ),
    );
  }
}
