import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Login extends StatelessWidget {
  static const String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      drawer: MainDrawer(),
    );
  }
}
