import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/home/infoAggiornamenti.dart';
import 'package:fdmApp/screens/home/mainBarbiana.dart';
import 'package:fdmApp/screens/home/mainNews.dart';
import 'package:fdmApp/screens/loadUsername.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'badConnection.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = "/home";
  MyHomePage({this.app});
  final FirebaseApp app;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  showNews() async {
    await showInfo();
    await showUpdate();
  }

  showInfo() async {
    //get data from database and if there's show the notification
  }

  showUpdate() async {
    //get updates info from database and if there's move to the application
    List<String> infos = [];
    Navigator.pushNamed(
      context,
      InfoAggiornamento.routeName,
      arguments: infos,
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    check() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        isIOS
            ? await showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Icon(
                    Icons.error,
                    size: 50.0,
                    color: Colors.red,
                  ),
                  content: Text(
                    "Connessione Assente, alcuni servizi potrebbero essere bloccati!",
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
            : await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Icon(
                    Icons.error,
                    size: 50.0,
                    color: Colors.red,
                  ),
                  content: Text(
                    "Connessione Assente, alcuni servizi potrebbero essere bloccati!",
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
        return null;
      } else {
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Fondazione Don Milani",
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
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/don_milani.png"),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 20),
                  child: MainNews(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 20),
                  child: MainBarbiana(),
                ),
                FutureBuilder(
                  future: check(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Future<dynamic>> snapshot) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                ),
                FutureBuilder(
                  future: LoadUsername().getUser(context, database),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                ),
                FutureBuilder(
                  future: showNews(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return SizedBox(
                      height: 1,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
