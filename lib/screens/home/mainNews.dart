import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainNews extends StatelessWidget {
  final List<String> infos = ["Evento 1!", "Evento 2!"];
  final List<String> images = [
    "assets/images/eventi.jpg",
    "assets/images/eventi1.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[0]),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: BorderedText(
                  strokeWidth: 3.0,
                  strokeColor: Colors.black,
                  child: Text(
                    infos[0],
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[1]),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: BorderedText(
                  strokeWidth: 3.0,
                  strokeColor: Colors.black,
                  child: Text(
                    infos[1],
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      options: CarouselOptions(
          enlargeCenterPage: true,
          height: 200.0,
          aspectRatio: 4 / 3,
          enableInfiniteScroll: true,
          viewportFraction: 0.8),
    );
  }
}
