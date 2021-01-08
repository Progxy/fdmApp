import 'package:flutter/material.dart';

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
    );
  }
}
