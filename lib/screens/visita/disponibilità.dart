import 'package:fdmApp/screens/databaseManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilizzo.dart';

class Disponibilita extends StatefulWidget {
  static const String routeName = "/disponibilità";

  Disponibilita({this.app});
  final FirebaseApp app;

  @override
  _DisponibilitaState createState() => _DisponibilitaState();
}

class _DisponibilitaState extends State<Disponibilita> {
  bool isValidDate = false;
  DateTime _dateTime;
  String resultDisponibility = "Nessuna Data Scelta";
  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    getData(FirebaseDatabase database) async {
      List data = await DatabaseManager().getDisponibilita(database);
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
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                var datas = await getData(database);
                //il datePicker deve poter prendere anche l'ora
                //e poi verificarla
                final DateFormat formatters = DateFormat('dd/MM/yyyy HH:mm');
                final DateFormat formatter = DateFormat('dd-MM-yyyy');
                for (var element in datas) {
                  List hours = element[1].split("-");
                  String newElement = formatter.format(element[0]);
                  String day = newElement.replaceAll("-", "/");
                  for (var hour in hours) {
                    String dateTime = day + " " + hour;
                    DateTime date = formatters.parse(dateTime);
                    if (_dateTime.compareTo(date) == 0) {
                      isValidDate = true;
                      break;
                    } else {
                      isValidDate = false;
                    }
                  }
                }
                setState(() {
                  _dateTime = date;
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
          /*
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
        */
        ],
      ),
    );
  }
}
