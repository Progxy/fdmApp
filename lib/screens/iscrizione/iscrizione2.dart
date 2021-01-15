import 'package:fdmApp/screens/iscrizione/iscrizione3.dart';
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
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: ButtonTheme(
                minWidth: 150.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultIscrizione()));
                  },
                  child: Text(
                    "Paga e Concludi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  color: Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
