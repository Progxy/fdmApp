import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Media extends StatelessWidget {
  static const String routeName = "/media";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto e Video"),
      ),
      drawer: MainDrawer(),
    );
  }
}
