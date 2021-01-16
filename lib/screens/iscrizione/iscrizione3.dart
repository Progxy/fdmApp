import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/iscrizione/DatiAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../painter.dart';

class ResultIscrizione extends StatefulWidget {
  static const String routeName = "/resultiscrizione";

  @override
  _ResultIscrizioneState createState() => _ResultIscrizioneState();
}

class _ResultIscrizioneState extends State<ResultIscrizione> {
  Map data = DatiAccount.datiSocio;

  @override
  Widget build(BuildContext context) {
    // final String email = data["email"];
    // final String password = data["password"];
    // final String username = data["username"];
    // final String indirizzo = data["indirizzo"];
    // final String id = data["id"];
    final String email = "ciccio@gmail.com";
    final String password = "Semonide12";
    final String username = "Akiller";
    final String indirizzo = "via aprocida";
    final String id = "NFN14114";
    return Scaffold(
      appBar: AppBar(
        title: Text("Iscrizione Completata"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Congratulazioni sei diventato un Socio della Fondazione Don Milani!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Questi sono i dati per eseguire l'accesso nel tuo account:\nEmail : $email,\n Password : $password,\nUsername : $username.\nPrima verifica il tuo account attraverso il link che abbiamo mandato a questa email : $email. Inoltre la tessera sarà consegnata al seguente indirizzo : $indirizzo, se volesse cambiarlo ci scriva a contatti@donmilani.com, scrivendo '$id - Cambio indirizzo di spedizione' nell'oggetto, o anche per eventuali chiarimenti.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "La Fondazione Don Milani.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Icon(
                Icons.home,
                size: 50.0,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: CustomPaint(
                    size: Size(50, 50),
                    painter: MyPainter(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "2",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: CustomPaint(
                    size: Size(50, 50),
                    painter: MyPainter(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "3",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
