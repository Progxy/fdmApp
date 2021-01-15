import 'package:dotted_line/dotted_line.dart';
import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

      body: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "1",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          // DottedLine(
          //   direction: Axis.horizontal,
          //   lineLength: 100,
          //   lineThickness: 3.0,
          //   dashLength: 6.0,
          //   dashColor: Colors.blueGrey,
          //   dashGapLength: 6.0,
          //   dashGapColor: Colors.transparent,
          // ),
          SizedBox(
            width: 100,
            child: CustomPaint(
              size: Size(50, 50),
              painter: MyPainter(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "2",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          // DottedLine(
          //   direction: Axis.horizontal,
          //   lineLength: 100,
          //   lineThickness: 3.0,
          //   dashLength: 6.0,
          //   dashColor: Colors.blueGrey,
          //   dashGapLength: 6.0,
          //   dashGapColor: Colors.transparent,
          // ),
          SizedBox(
            width: 100,
            child: CustomPaint(
              size: Size(50, 50),
              painter: MyPainter(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "3",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, 25);
    final p2 = Offset(95, 25);
    final paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
