import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/iscrizione/DatiAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultIscrizione extends StatefulWidget {
  static const String routeName = "/resultiscrizione";

  @override
  _ResultIscrizioneState createState() => _ResultIscrizioneState();
}

class _ResultIscrizioneState extends State<ResultIscrizione> {
  Map data = DatiAccount.datiSocio;

  @override
  Widget build(BuildContext context) {
    final String email = data["email"];
    final String password = data["password"];
    final String username = data["username"];
    final String indirizzo = data["indirizzo"];
    final String id = data["id"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Iscrizione Completata"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Congratulazioni sei diventato un Socio della Fondazione Don Milani!",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Questi sono i dati per eseguire l'accesso nel tuo account:\nEmail : $email,\n Password : $password,\nUsername : $username.\nPrima verifica il tuo account attraverso il link che abbiamo mandato a questa email : $email. Inoltre la tessera sarà consegnata al seguente indirizzo : $indirizzo, se volesse cambiarlo ci scriva a contatti@donmilani.com, scrivendo 'Cambio indirizzo di spedizione - $id' nell'oggetto, o anche per eventuali chiarimenti.",
              textAlign: TextAlign.center,
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
            Image(
              image: AssetImage("assets/images/don_milani.png"),
            )
          ],
        ),
      ),
    );
  }
}
