import 'package:dotted_line/dotted_line.dart';
import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RecuperoPassword extends StatefulWidget {
  static const String routeName = "/recuperopassword";

  @override
  _RecuperoPasswordState createState() => _RecuperoPasswordState();
}

class _RecuperoPasswordState extends State<RecuperoPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recupero Password"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //ottieni la mail, verifica che corrisponda un'utente ad essa:
            //se esiste manda una email con la password e la mail;
            //se no manda una mail che dice di non aver trovato niente.
            //oppure fai lo stesso passaggio attraverso l'username.
          ],
        ),
      ),
    );
  }
}
