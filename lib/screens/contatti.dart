import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Contatti extends StatelessWidget {
  static const String routeName = "/contatti";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatti"),
      ),
      drawer: MainDrawer(),
    );
  }
}
