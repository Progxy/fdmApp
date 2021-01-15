import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultIscrizione extends StatefulWidget {
  @override
  _ResultIscrizioneState createState() => _ResultIscrizioneState();
}

class _ResultIscrizioneState extends State<ResultIscrizione> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iscrizione Completata"),
      ),
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
