import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

import 'home/mainDrawer.dart';

class Media extends StatelessWidget {
  static const String routeName = "/media";
  final List<List> mediaPhoto = [
    [
      "title",
      "date",
      "url",
      "extract",
    ],
    [
      "title1",
      "date1",
      "url1",
      "extract1",
    ],
  ];
  final List<List> mediaVideo = [
    [
      "title2",
      "date2",
      "url2",
      "extract2",
    ],
    [
      "title3",
      "date3",
      "url3",
      "extract3",
    ],
  ];
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
              items: mediaPhoto
                  .map(
                    (infos) => new Container(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Marquee(
                                child: Text(
                                  infos[0] + " - " + infos[1],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                animationDuration: Duration(seconds: 1),
                                backDuration: Duration(milliseconds: 5000),
                                pauseDuration: Duration(milliseconds: 2500),
                                directionMarguee: DirectionMarguee.oneDirection,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200.0,
                  aspectRatio: 4 / 3,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8),
            ),
            SizedBox(
              height: 25,
            ),
            CarouselSlider(
              items: mediaVideo
                  .map(
                    (infos) => new Container(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Marquee(
                                child: Text(
                                  infos[0] + " - " + infos[1],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                animationDuration: Duration(seconds: 1),
                                backDuration: Duration(milliseconds: 5000),
                                pauseDuration: Duration(milliseconds: 2500),
                                directionMarguee: DirectionMarguee.oneDirection,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200.0,
                  aspectRatio: 4 / 3,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8),
            )
          ],
        ),
      ),
    );
  }
}
