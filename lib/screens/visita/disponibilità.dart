import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/databaseManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../badConnection.dart';
import '../feedback.dart';
import '../utilizzo.dart';

class Disponibilita extends StatefulWidget {
  static const String routeName = "/disponibilità";

  Disponibilita({this.app});
  final FirebaseApp app;

  @override
  _DisponibilitaState createState() => _DisponibilitaState();
}

class _DisponibilitaState extends State<Disponibilita> {
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

  bool isValidDate = false;
  DateTime _dateTime;
  String resultDisponibility = "";
  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    getData(FirebaseDatabase database) async {
      List data = await DatabaseManager().getDisponibilita(database);
      return data;
    }

    getIndisponibility(FirebaseDatabase database) async {
      List data = await DatabaseManager().getIndisponibilita(database);
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Calendario Disponibilità",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
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
          children: <Widget>[
            SizedBox(
              height: 130,
            ),
            Center(
              child: RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Scegli una Data",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                color: Color.fromARGB(255, 24, 37, 102),
                onPressed: () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: const Color.fromARGB(255, 24, 37, 102),
                          accentColor: const Color.fromARGB(255, 24, 37, 102),
                          colorScheme: ColorScheme.light(
                              primary: const Color.fromARGB(255, 24, 37, 102)),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  var datas = await getData(database);
                  var indisponibility = await getIndisponibility(database);
                  setState(() {
                    if (date == null) {
                      return;
                    }
                    _dateTime = date;
                    final DateFormat formatter = DateFormat('dd-MM-yyyy');
                    for (var element in datas) {
                      List hours = element[1].split("-");
                      DateTime confrontableDate = formatter.parse(element[0]);
                      if (_dateTime.compareTo(confrontableDate) == 0) {
                        isValidDate = true;
                        resultDisponibility = "";
                        for (var hour in hours) {
                          resultDisponibility += hour;
                          resultDisponibility += "\n";
                        }
                        if (isIOS) {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: Text(
                                "Orari Disponibili",
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              content: Text(
                                resultDisponibility,
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
                                "Orari Disponibili",
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              content: Text(
                                resultDisponibility,
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        return;
                      } else {
                        isValidDate = false;
                      }
                    }
                    for (var element in indisponibility) {
                      String prenotati = element[1];
                      DateTime confrontableDate = formatter.parse(element[0]);
                      if (_dateTime.compareTo(confrontableDate) == 0) {
                        isValidDate = true;
                        if (isIOS) {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: Text(
                                "Data Prenotata da : ",
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              content: Text(
                                prenotati,
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
                                "Data Prenotata da : ",
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              content: Text(
                                prenotati,
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        return;
                      }
                    }
                    if (!isValidDate) {
                      if (isIOS) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: Text(
                              "Data Non Disponibile",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            content: Text(
                              "Si prega di scegliere un'altra data!",
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
                              "Data Non Disponibile",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            content: Text(
                              "Si prega di scegliere un'altra data!",
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                              )
                            ],
                          ),
                        );
                      }
                      return;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 135,
            ),
            Image(
              image: AssetImage("assets/images/don_milani.png"),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
