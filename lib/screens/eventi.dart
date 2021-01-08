import 'package:flutter/material.dart';

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
    );
  }
}
