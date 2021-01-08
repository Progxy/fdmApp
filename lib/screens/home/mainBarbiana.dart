import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainBarbiana extends StatelessWidget {
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
                  "Info su Barbiana 1 !",
                  style: TextStyle(fontSize: 40),
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
                  "Info su Barbiana 2 !",
                  style: TextStyle(fontSize: 40),
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
