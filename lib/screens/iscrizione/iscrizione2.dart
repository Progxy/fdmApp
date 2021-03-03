import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fdmApp/screens/iscrizione/DatiAccount.dart';
import 'package:fdmApp/screens/iscrizione/iscrizione3.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer2/mailer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../authentication_service.dart';
import '../badConnection.dart';
import '../feedback.dart';
import '../painter.dart';
import '../paymentService.dart';

class PayIscrizione extends StatefulWidget {
  static const String routeName = "/payiscrizione";
  PayIscrizione({this.app});
  final FirebaseApp app;

  @override
  _PayIscrizioneState createState() => _PayIscrizioneState();
}

class _PayIscrizioneState extends State<PayIscrizione> {
  final List<String> choices = <String>[
    "FeedBack",
    "Aiuto",
  ];

  //metodo per inviare i dati necessari al nuovo socio

  sendDataToSocio(Map datas) async {
    var options = new GmailSmtpOptions()
      ..username = 'ermes.express.fdm@gmail.com'
      ..password = 'CASTELLO1967';

    var emailTransport = new SmtpTransport(options);

    final String username = datas["username"];

    final String password = datas["password"];

    final String id = datas["id"];

    final String email = datas["email"];

    var envelope = new Envelope()
      ..from = 'ermes.express.fdm@gmail.com'
      ..recipients.add(email)
      ..subject = 'Conferma Iscrizione'
      ..text =
          "Le confermiamo la sua iscrizione, di seguito le forniamo i suoi dati riguardo l'area soci : \n\nId : $id\nUsername : $username\nPassword : $password\nPer eventuali richieste si prega di rispondere a eossmario@gmail.com !\n\nErmes Express Fdm";

    await emailTransport.send(envelope).then((envelope) async {
      print("Success!");
    }).catchError((e) async {
      print(e);
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(
              "Errore",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            content: Text(
              "Ops... Qualcosa è andato storto!\nNon è stato possibile inviare la email!",
              style: TextStyle(
                fontSize: 27,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              )
            ],
          ),
        );
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              "Errore",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            content: Text(
              "Ops... Qualcosa è andato storto!\nNon è stato possibile inviare la email!",
              style: TextStyle(
                fontSize: 27,
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              )
            ],
          ),
        );
      }
    });
  }

  //metodo per aggiungere il socio in firebase e aggiungere i dati del socio nel database firebase

  addAccount(Map datas, FirebaseDatabase database) async {
    await context.read<AuthenticationService>().signUp(
          email: datas["email"].trim(),
          password: datas["password"].trim(),
        );
    final firebaseAuthCheck = FirebaseAuth.instance.currentUser.uid;
    if (firebaseAuthCheck == null) {
      return;
    }
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String id = datas["id"];
    final DateTime now = DateTime.now();
    final DateTime expDate = new DateTime(now.year, 12, 31);
    final String date = formatter.format(expDate).toString();
    final String email = datas["email"];
    final String password = datas["password"];
    final String username = datas["username"];
    final int year = now.year;
    final String anniSocialis = year.toString();
    final String scadenza = expDate.day.toString() +
        "-" +
        expDate.month.toString() +
        "-" +
        expDate.year.toString();

    var databaseReference = database.reference().child(firebaseAuthCheck);

    databaseReference.child("Id").set({id: email});
    databaseReference.child("Date").set({date: email});
    databaseReference.child("Pass").set({password: email});
    databaseReference.child("User").set({username: email});

    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    try {
      secondaryDb.child("Tessere").child(id).set({
        "anniSociali": anniSocialis,
        "email": email,
        "provincia": datas["provincia"],
        "indirizzo": datas["indirizzo"],
        "telefono": datas["telefono"],
        "intestazione": datas["intestazione gruppo"],
        "nome": datas["nome"],
        "cognome": datas["cognome"],
        "citta": datas["città"],
        "cap": datas["CAP"],
        "Tipo di Tessera": datas["tipo di gruppo"],
        "messaggio": datas["messaggio"],
        "username": username,
        "password": password,
        "data": date,
        "scadenza": scadenza,
        "scaduto": false,
        "fattoDa": "fdmApp"
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  final Map data = DatiAccount.datiSocio;

  ScrollController _controller = ScrollController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  payViaNewCard(
      BuildContext context, Map datas, FirebaseDatabase database) async {
    final String _price = data["prezzo"];
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Caricamento...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: _price, currency: 'EUR');
    if (response.message == "Transaction successful") {
      await addAccount(datas, database);
      await sendDataToSocio(datas);
      await dialog.hide();
      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 55.0,
                ),
                content: Text(
                  "Transazione effetuata con successo!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, ResultIscrizione.routeName);
                    },
                  )
                ],
              ),
            )
          : showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 55.0,
                ),
                content: Text(
                  "Transazione effetuata con successo!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, ResultIscrizione.routeName);
                    },
                  )
                ],
              ),
            );
    } else {
      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 55.0,
                ),
                content: Text(
                  "Transazione effetuata con esito negativo!\n${response.message}",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  )
                ],
              ),
            )
          : showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 55.0,
                ),
                content: Text(
                  "Transazione effetuata con esito negativo!\n${response.message}",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  )
                ],
              ),
            );
    }
    return null;
  }

  void choiceAction(String choice) async {
    if (choice == "Aiuto") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Utilizzo()));
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BadConnection()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedBack()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Pagamento Iscrizione",
            style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList();
            },
          )
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
            SizedBox(
              height: 90,
              width: 380,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                padding: const EdgeInsets.all(20),
                children: <Widget>[
                  ButtonTheme(
                    height: 57,
                    child: RaisedButton(
                      child: Text(
                        "Paga e Continua",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      color: Color.fromARGB(255, 24, 37, 102),
                      onPressed: () {
                        payViaNewCard(context, data, database);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 24, 37, 102),
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
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
                    color: Color.fromARGB(255, 24, 37, 102),
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
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
                ),
                SizedBox(
                  width: 10,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 100,
                  lineThickness: 3.0,
                  dashLength: 6.0,
                  dashColor: Color.fromARGB(255, 24, 37, 102),
                  dashGapLength: 6.0,
                  dashGapColor: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 24, 37, 102),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
