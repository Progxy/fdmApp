import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CambioPassword extends StatefulWidget {
  @override
  _CambioPasswordState createState() => _CambioPasswordState();
}

class _CambioPasswordState extends State<CambioPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambio Password"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[],
        ),
      ),
    );
  }
}
