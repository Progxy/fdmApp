import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timelines/timelines.dart';

class RecuperoPassword extends StatefulWidget {
  static const String routeName = "/recuperopassword";

  @override
  _RecuperoPasswordState createState() => _RecuperoPasswordState();
}

class _RecuperoPasswordState extends State<RecuperoPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recupero Password"),
      ),
      drawer: MainDrawer(),
      // body: SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       //ottieni la mail, verifica che corrisponda un'utente ad essa:
      //       //se esiste manda una email con la password e la mail;
      //       //se no manda una mail che dice di non aver trovato niente.
      //       //oppure fai lo stesso passaggio attraverso l'username.
      //     ],
      //   ),
      // ),

      body: Container(
        color: Colors.white,
        constraints: const BoxConstraints(maxHeight: 160),
        child: Flexible(
          child: Center(
            child: FixedTimeline(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(
                  space: 30.0,
                  thickness: 5.0,
                ),
              ),
              children: [
                SizedBox(
                  height: 20.0,
                  child: DashedLineConnector(),
                ),
                SizedBox(
                  height: 80.0,
                  child: TimelineNode(
                    indicator: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Complex'),
                      ),
                    ),
                    startConnector: DashedLineConnector(),
                    endConnector: SolidLineConnector(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
