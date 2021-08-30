import 'dart:collection';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mailer2/mailer.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'badConnection.dart';
import 'feedback.dart';

class RecuperoPassword extends StatefulWidget {
  static const String routeName = "/recuperopassword";

  RecuperoPassword({this.app});
  final FirebaseApp app;

  @override
  _RecuperoPasswordState createState() => _RecuperoPasswordState();
}

class _RecuperoPasswordState extends State<RecuperoPassword> {
  getAccountInfo(String id, String email, FirebaseDatabase database) async {
    bool result = false;
    String authId;
    await database.reference().once().then((DataSnapshot snapshot) async {
      Map val = new Map.from(snapshot.value);
      List names = val.keys.toList();
      for (int index = 0; index < names.length; index++) {
        if ((names[index] != "Disponibilita") &&
            (names[index] != "Indisponibilita") &&
            (names[index] != "News") &&
            (names[index] != "Media") &&
            (names[index] != "SeCHS")) {
          await database
              .reference()
              .child(names[index] + "/Id")
              .once()
              .then((DataSnapshot snapshot) {
            Map valId = new Map.from(snapshot.value);
            String idCopy = valId.keys.toList()[0];
            String emailCopy = valId.values.toList()[0];
            if (idCopy == id && emailCopy == email) {
              result = true;
              authId = names[index];
              return;
            }
          });
          if (result) {
            break;
          }
        }
      }
      if (result) {
        return;
      }
    });
    if (result) {
      return authId;
    }
    return null;
  }

  sendCredentials(String email, String password, String username, String id,
      String expDate) async {
    var options = new GmailSmtpOptions()
      ..username = 'ermes.express.fdm@gmail.com'
      ..password = 'CASTELLO1967';

    var emailTransport = new SmtpTransport(options);

    var envelope = new Envelope()
      ..from = 'ermes.express.fdm@gmail.com'
      ..recipients.add(email)
      ..subject = 'Recupero Credenziali'
      ..text =
          "Ecco le credenziali richieste :\n\nUsername : $username,\nEmail : $email,\nPassword : $password,\nScadenza : $expDate,\nId : $id." +
              "\n\nErmes-Express FDM";

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
              TextButton(
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

  getAccount(String email, String id, FirebaseDatabase database) async {
    String password;
    String username;
    String expDate;
    final String authId = await getAccountInfo(id, email, database);
    if (authId == null) {
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
                  "Id o Email non trovato!",
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
                  "Id o Email non trovato!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  TextButton(
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
      return;
    }
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Caricamento...');
    await dialog.show();
    await database
        .reference()
        .child(authId)
        .child("Pass")
        .orderByValue()
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        return password = null;
      }
      LinkedHashMap<dynamic, dynamic> values = snapshot.value;
      Map<String, String> map =
          values.map((a, b) => MapEntry(a as String, b as String));
      password =
          map.keys.firstWhere((k) => map[k] == email, orElse: () => null);
    });
    await database
        .reference()
        .child(authId)
        .child("User")
        .orderByValue()
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        return username = null;
      }
      LinkedHashMap<dynamic, dynamic> values = snapshot.value;
      Map<String, String> map =
          values.map((a, b) => MapEntry(a as String, b as String));
      map.forEach((k, val) => {username = k});
    });
    await database
        .reference()
        .child(authId)
        .child("Date")
        .orderByValue()
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        return expDate = null;
      }
      LinkedHashMap<dynamic, dynamic> values = snapshot.value;
      Map<String, String> map =
          values.map((a, b) => MapEntry(a as String, b as String));
      map.forEach((k, val) => {expDate = k});
    });
    if (password != null && username != null && expDate != null) {
      await sendCredentials(email, password, username, id, expDate);
      await dialog.hide();
      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 50.0,
                ),
                content: Text(
                  "E' stata mandata una email con le credenziali richieste!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
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
                  size: 50.0,
                ),
                content: Text(
                  "E' stata mandata una email con le credenziali richieste!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  )
                ],
              ),
            );
    } else {
      await dialog.hide();
      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50.0,
                ),
                content: Text(
                  "Non esiste nessun account con questa email!",
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
                  size: 50.0,
                ),
                content: Text(
                  "Non esiste nessun account con questa email!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  TextButton(
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
  }

  final List<String> choices = <String>[
    "FeedBack",
    "Aiuto",
  ];

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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  String email;
  String id;

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Recupero Credenziali",
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
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Inserire l'email",
                hintStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              validator: (value) {
                String _emailPattern =
                    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
                bool isValid(String pattern, String input) =>
                    RegExp(pattern).hasMatch(input);
                if (value == null) {
                  return "Dati Mancanti";
                } else if (isValid(_emailPattern, value) == false) {
                  return "Email Errata";
                }
                email = value;
                return null;
              },
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(
                hintText: "Inserire l'id dell'iscrizione",
                hintStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
                labelText: "Id Iscrizione",
                labelStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Dati Mancanti";
                }
                id = value;
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ButtonTheme(
                height: 50.0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 24, 37, 102),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await getAccount(email, id, database);
                    } else {
                      if (isIOS) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: Text(
                              "Errore",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            content: Text(
                              "Email o Password mancanti!",
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
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
                              "Email o Password mancanti!",
                              style: TextStyle(
                                fontSize: 27,
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Recupera Credenziali",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Image(
              image: AssetImage("assets/images/don_milani.png"),
              fit: BoxFit.cover,
            ),
          ],
        ),
      )),
    );
  }
}
