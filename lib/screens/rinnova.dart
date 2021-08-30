import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/VerifyExpiration.dart';
import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:fdmApp/screens/paymentService.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';

import 'badConnection.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';

class Rinnova extends StatefulWidget {
  static const String routeName = "/rinnova";
  Rinnova({this.app});
  final FirebaseApp app;

  @override
  _RinnovaState createState() => _RinnovaState();
}

class _RinnovaState extends State<Rinnova> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  String email;
  String id;
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

  getAccount(String id, String email, FirebaseDatabase database) async {
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

  getTypeTicket(String id) async {
    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    String result;
    try {
      await secondaryDb
          .child("Tessere/" + id + "/Tipo di Tessera")
          .orderByValue()
          .once()
          .then((DataSnapshot snapshot) {
        result = snapshot.value.toString();
      });
      return result;
    } catch (e) {
      return null;
    }
  }

  resetAccount(String id, String authId, String email,
      FirebaseDatabase database, String yearsCount) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateTime now = DateTime.now();
    final DateTime expDate = new DateTime(now.year, 12, 31);
    final String date = formatter.format(expDate).toString();
    var databaseReference = database.reference().child(authId);
    databaseReference.child("Date").update({date: email});
    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    try {
      secondaryDb.child("Tessere/" + id).update({
        "scaduto": false,
        "anniSociali": yearsCount,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  getYearsCount(String id) async {
    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    String anniSocialis;
    try {
      await secondaryDb
          .child("Tessere/" + id + "/anniSociali")
          .orderByValue()
          .once()
          .then((DataSnapshot snapshot) {
        anniSocialis = snapshot.value.toString();
      });
      return anniSocialis;
    } catch (e) {
      return "";
    }
  }

  addRinnovoNotification(String id, String email, String anniSocialis) async {
    String typeTicket = await getTypeTicket(id);
    String fdbUrl2 = "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    String nome;
    String cognome;
    try {
      await secondaryDb
          .child("Tessere/" + id + "/nome")
          .orderByValue()
          .once()
          .then((DataSnapshot snapshot) {
        nome = snapshot.value.toString();
      });
    } catch (e) {
      print(e);
    }
    try {
      await secondaryDb
          .child("Tessere/" + id + "/cognome")
          .orderByValue()
          .once()
          .then((DataSnapshot snapshot) {
        cognome = snapshot.value.toString();
      });
    } catch (e) {
      print(e);
    }
    try {
      secondaryDb.child("Rinnovi/" + id).set({
        "tipo di tessera": typeTicket,
        "email": email,
        "nome": nome,
        "cognome": cognome,
        "anniSociali": anniSocialis,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  payViaNewCard(BuildContext context, FirebaseDatabase database) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Caricamento...');
    await dialog.show();
    String _price = await getTypeTicket(id);
    switch (_price) {
      case "Singolo":
        {
          _price = "1500";
          break;
        }

      case "Familiare":
        {
          _price = "3000";
          break;
        }
      case "Gruppo":
        {
          _price = "5000";
          break;
        }

      default:
        {
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
                      "Ops...\nSi è verificato un errore!",
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
                      "Ops...\nSi è verificato un errore!",
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
          return;
        }
    }
    var response =
        await StripeService.payWithNewCard(amount: _price, currency: 'EUR');
    if (response.message == "Transaction successful") {
      final String authId = await getAccount(id, email, database);
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
                    "Id non trovato!",
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
                    "Id non trovato!",
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
        return;
      }
      final DateTime now = DateTime.now();
      final String year = now.year.toString();
      String anniSocialis = await getYearsCount(id);
      anniSocialis = anniSocialis + "-" + year;
      await resetAccount(id, authId, email, database, anniSocialis);
      await addRinnovoNotification(id, email, anniSocialis);
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
                  "Iscrizione rinnovata con successo!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
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
                  "Iscrizione rinnovata con successo!",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
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
    return null;
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Rinnova Iscrizione",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
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
                minWidth: 150.0,
                height: 50.0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 24, 37, 102),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      bool isExpired =
                          await VerifyExpiration().isAlreadyExpired(id);
                      if (isExpired == null) {
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  title: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 55.0,
                                  ),
                                  content: Text(
                                    "Id non trovato!",
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
                                                builder: (context) =>
                                                    MyHomePage()));
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
                                    "Id non trovato!",
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
                                                builder: (context) =>
                                                    MyHomePage()));
                                      },
                                    )
                                  ],
                                ),
                              );
                        return;
                      }
                      if (!isExpired) {
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  title: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 55.0,
                                  ),
                                  content: Text(
                                    "Iscrizione ancora valida!",
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
                                                builder: (context) =>
                                                    MyHomePage()));
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
                                    "Iscrizione ancora valida!",
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
                                                builder: (context) =>
                                                    MyHomePage()));
                                      },
                                    )
                                  ],
                                ),
                              );
                        return;
                      }
                      await payViaNewCard(context, database);
                      return;
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
                              "Email o Id mancanti!",
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
                              "Email o Id mancanti!",
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
                    "Rinnova Iscrizione",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
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
