import 'package:fdmApp/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadConnection extends StatelessWidget {
  static const String routeName = "/badconnection";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Connessione Assente",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              size: 30,
            ),
            onPressed: () {
              print("ciò");
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Center(
              child: Icon(
                Icons.error,
                size: 65,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "La Connessione è Assente, per cui è stato impossile connettersi al servizio, per risolvere il problema connettersi ad Internet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FloatingActionButton(
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
