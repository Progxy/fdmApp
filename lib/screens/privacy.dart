import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Privacy extends StatelessWidget {
  static const String routeName = "/privacy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy"),
      ),
      drawer: MainDrawer(),
    );
  }
}
