import 'package:fdmApp/authentication_service.dart';
import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Errore"),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error,
            size: 50.0,
            color: Colors.blueGrey,
          ),
          Text(
            "Email o Password invalida!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          Center(
            child: FloatingActionButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 40.0,
              ),
              backgroundColor: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
