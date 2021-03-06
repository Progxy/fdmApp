import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/SeCHS/stampaBuilder.dart';
import 'package:fdmApp/screens/eventi/eventiBuilder.dart';
import 'package:fdmApp/screens/eventi/infoBuilder.dart';
import 'package:fdmApp/screens/home/infoAggiornamenti.dart';
import 'package:fdmApp/screens/loadUsername.dart';
import 'package:fdmApp/screens/logFileManager.dart';
import 'package:fdmApp/screens/media/fotoBuilder.dart';
import 'package:fdmApp/screens/media/videoBuilder.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'SeCHS/CHSBuilder.dart';
import 'badConnection.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';
import 'manutenzione.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = "/home";
  MyHomePage({this.app});
  final FirebaseApp app;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin fltrNotification;
  final Map methodsNews = {
    0: FotoBuilder(),
    1: VideoBuilder(),
    2: CHSBuilder(),
    3: StampaBuilder(),
    4: EventiBuilder(),
    5: InfoBuilder(),
  };
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

  showNews(FirebaseDatabase database) async {
    bool result = await isOnManutenzione(database);
    if (result) {
      return;
    }
    await showInfo(database);
    bool isFirstPlay = await LogFileManager().firstVisit();
    if (isFirstPlay) {
      await showUpdate();
    }
  }

  showInfo(FirebaseDatabase database) async {
    List<String> infoText = [];
    List<String> infoTitle = [];
    await database
        .reference()
        .child("Info")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      map.forEach((name, val) => infoTitle.add(name));
      map.forEach((name, value) => infoText.add(value));
    }).catchError((e) {
      print("\n-\nErrore : $e\n-\n");
    });
    for (int index = infoTitle.length - 1; index >= 0; index--) {
      String element = infoTitle[index];
      bool isAlreadySeen = await LogFileManager().getData(element.toString());
      if (isAlreadySeen) {
        infoTitle.removeAt(index);
        infoText.removeAt(index);
      }
    }
    int ind = 0;
    for (var title in infoTitle) {
      String text = infoText[ind];
      await showNotification(title, text);
      ind++;
    }
  }

  showUpdate() async {
    List<String> infos = [
      "Aggiornamento 0.2",
      "In questo aggiornamento sono state implementate le seguenti funzioni : \nDisdici;\nRinnova.\nInoltre sono state aggiornate tutte le altre funzioni e soprattutto la grafica."
    ];
    Navigator.pushNamed(
      context,
      InfoAggiornamento.routeName,
      arguments: infos,
    );
  }

  isOnManutenzione(FirebaseDatabase database) async {
    bool result = false;
    await database
        .reference()
        .child("Manutenzione")
        .once()
        .then((DataSnapshot snapshot) {
      result = snapshot.value;
    }).catchError((e) {
      print("\n-\nErrore : $e\n-\n");
    });
    if (result) {
      Navigator.pushReplacementNamed(context, Manutenzione.routeName);
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings("ic_stat_dn_ml");
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    await LogFileManager().storeData(payload);
  }

  Future showNotification(String title, String body) async {
    var androidDetails = new AndroidNotificationDetails(
        "Fondazione Don Milani", "Fondazione Don Milani", "Notifica di Fdm",
        importance: Importance.max, color: Color.fromARGB(255, 24, 37, 102));
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);
    await fltrNotification.show(0, title,
        "$body\nClicca per segnare come vista!", generalNotificationDetails,
        payload: title);
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
        return null;
      } else {
        return null;
      }
    }

    Random random = new Random();
    final int firstNumber = random.nextInt(5);
    int secondNumber = random.nextInt(5);
    secondNumber == firstNumber
        ? firstNumber == 5
            ? secondNumber -= 1
            : secondNumber += 1
        : secondNumber = secondNumber;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Home",
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
                  child: methodsNews[firstNumber],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 20),
                  child: methodsNews[secondNumber],
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
                  future: showNews(database),
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
