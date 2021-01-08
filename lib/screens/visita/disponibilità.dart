import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Disponibilita extends StatelessWidget {
  static const String routeName = "/disponibilità";
  final List<List> disponibility = [
    ["12/08/2021", "Burberi Agostino"],
    ["21/10/2021", "Emanuele Burberi"],
    ["12/11/2021", "Burberi Agostino e \nBurberi Emanuele"]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario Disponibilità"),
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
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          CarouselSlider(
            items: disponibility
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
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 75),
                            child: BorderedText(
                              strokeWidth: 4.0,
                              strokeColor: Colors.black,
                              child: Text(
                                "Il giorno " +
                                    i[0] +
                                    "\nci saranno i volontari : \n" +
                                    i[1],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))
                .toList(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: 350.0,
                aspectRatio: 4 / 3,
                enableInfiniteScroll: true,
                viewportFraction: 0.8),
          )
          //Carousel_slider with date and volounteer and barbiana as background image
        ],
      ),
    );
  }
}
