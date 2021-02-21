import 'package:fdmApp/screens/home.dart';
import 'package:fdmApp/screens/iscrizione.dart';
import 'package:flutter/material.dart';

class IscrizioneScaduta extends StatefulWidget {
  static const String routeName = "/iscrizionescaduta";

  @override
  _IscrizioneScadutaState createState() => _IscrizioneScadutaState();
}

class _IscrizioneScadutaState extends State<IscrizioneScaduta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Iscrizione Socio Scaduta",
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
              print("ciò");
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 65,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Siamo spiacenti, l'iscrizione a socio del seguente account è scaduta!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.home,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
                ButtonTheme(
                  height: 60,
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Iscrizione()));
                    },
                    child: Text(
                      "Ripristina",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Image(
              image: AssetImage("assets/images/don_milani.png"),
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
