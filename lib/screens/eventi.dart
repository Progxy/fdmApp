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
        title: Text("Eventi"),
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
