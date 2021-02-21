import 'package:fdmApp/authentication_service.dart';
import 'package:fdmApp/screens/home/accountInfo.dart';
import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class UserPage extends StatelessWidget {
  static const String routeName = "/userpage";
  final String name = AccountInfo.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Benvenuto $name",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              AccountInfo().resetCredentials();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.logout,
              size: 40.0,
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          "Benvenuto $name nella tua area personale!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
