import 'package:flutter/material.dart';

import '../login.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Errore"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 50.0,
            color: Colors.red,
          ),
          Text(
            "Email o Password invalida!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.home,
              size: 50.0,
            ),
            backgroundColor: Colors.blueGrey,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
    );
  }
}
