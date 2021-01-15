import 'package:fdmApp/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadConnection extends StatelessWidget {
  static const String routeName = "/badconnection";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connessione Assente"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.error,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "La Connessione è Assente, per cui è stato impossile connettersi al servizio, per risolvere il problema connettersi ad Internet!",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Icon(
                Icons.home,
                size: 50,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            SizedBox(
              height: 30,
            ),
            Image(
              image: AssetImage("assets/images/don_milani.png"),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
