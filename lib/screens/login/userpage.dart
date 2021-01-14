import 'package:fdmApp/authentication_service.dart';
import 'package:fdmApp/screens/home/accountInfo.dart';
import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  static const String routeName = "/userpage";
  final String name = AccountInfo.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Benvenuto $name"),
        leading: FloatingActionButton(
          onPressed: () {
            context.read<AuthenticationService>().signOut();
          },
          child: Icon(
            Icons.logout,
            size: 40.0,
          ),
          backgroundColor: Colors.blueGrey,
        ),
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
