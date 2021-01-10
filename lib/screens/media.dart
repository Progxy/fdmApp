import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

import 'home/mainDrawer.dart';

class Media extends StatelessWidget {
  static const String routeName = "/media";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto e Video"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CarouselSlider(
              items: [
                Marquee(
                  child: Text(
                      'This project is a starting point for a Dart package'),
                  direction: Axis.horizontal,
                  textDirection: TextDirection.rtl,
                  animationDuration: Duration(seconds: 1),
                  backDuration: Duration(milliseconds: 5000),
                  pauseDuration: Duration(milliseconds: 2500),
                  directionMarguee: DirectionMarguee.oneDirection,
                ),
              ],
              options: null,
            ),
            SizedBox(
              height: 25,
            ),
            CarouselSlider(
              items: [
                Marquee(
                  child: Text(
                      'This project is a starting point for a Dart package'),
                  direction: Axis.horizontal,
                  textDirection: TextDirection.rtl,
                  animationDuration: Duration(seconds: 1),
                  backDuration: Duration(milliseconds: 5000),
                  pauseDuration: Duration(milliseconds: 2500),
                  directionMarguee: DirectionMarguee.oneDirection,
                ),
              ],
              options: null,
            )
          ],
        ),
      ),
    );
  }
}
