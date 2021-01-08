import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Iscrizione extends StatelessWidget {
  static const String routeName = "/iscrizione";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diventa Socio"),
      ),
      drawer: MainDrawer(),
    );
  }
}
