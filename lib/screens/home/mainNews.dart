import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
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
                child: Text(
                  "Evento 1 !",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
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
                child: Text(
                  "Evento 2 !",
                  style: TextStyle(fontSize: 50),
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
