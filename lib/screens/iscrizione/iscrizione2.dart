import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayIscrizione extends StatefulWidget {
  static const String routeName = "/payiscrizione";

  @override
  _PayIscrizioneState createState() => _PayIscrizioneState();
}

class _PayIscrizioneState extends State<PayIscrizione> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
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
