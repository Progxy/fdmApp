import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Contatti extends StatelessWidget {
  static const String routeName = "/contatti";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatti"),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "CONTATTI",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "\nFONDAZIONE DON LORENZO MILANI",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "\nSede Legale:\nLoc. Barbiana, 9 – 50031 Vicchio Mugello (FI)\n\nSede Operativa:\nVia Spinuci, 19 – 50141 Firenze\nTel. e Fax: 055.418811\n\nE-mail: contatti@donlorenzomilani.it",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
