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
      body: Stack(
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
          FloatingActionButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Icon(
              Icons.home,
              size: 40.0,
            ),
            backgroundColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
