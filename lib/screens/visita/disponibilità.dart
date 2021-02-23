import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fdmApp/screens/databaseManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utilizzo.dart';

class Disponibilita extends StatefulWidget {
  static const String routeName = "/disponibilità";

  Disponibilita({this.app});
  final FirebaseApp app;

  @override
  _DisponibilitaState createState() => _DisponibilitaState();
}

class _DisponibilitaState extends State<Disponibilita> {
  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    List data = [];
    getData(FirebaseDatabase database) async {
      data = await DatabaseManager().getDisponibilita(database);
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
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Utilizzo()));
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Text(
                  "Giorni Disponibili\ne\nVolontari Presenti",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          FutureBuilder(
            future: getData(database),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return CarouselSlider(
                items: data
                    .map((i) => new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage("assets/images/barbiana.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ListView(
                          children: [
                            Container(
                              height: 450,
                              width: 380,
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 275,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 13.0,
                                              top: 13.0,
                                            ),
                                            child: BorderedText(
                                              strokeWidth: 4.0,
                                              strokeColor: Colors.black,
                                              child: Text(
                                                "Il giorno " +
                                                    i[0] +
                                                    "\nci saranno i volontari : \n" +
                                                    i[1],
                                                style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )))
                    .toList(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 450.0,
                    aspectRatio: 4 / 3,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8),
              );
            },
          ),
        ],
      ),
    );
  }
}
