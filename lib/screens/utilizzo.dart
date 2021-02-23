import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utilizzo extends StatelessWidget {
  static const String routeName = "/utilizzo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Guida all'utilizzo dell'applicazione",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Benvenuto nella pagina di utilizzo !",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "In questa pagina saranno mostrate tutte le funzionalità della FdmApp attraverso semplici passaggi !",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
