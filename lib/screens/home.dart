import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/home/mainBarbiana.dart';
import 'package:fdmApp/screens/home/mainNews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("Fondazione Don Milani"),
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
