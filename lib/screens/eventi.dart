import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Eventi extends StatelessWidget {
  static const String routeName = "/eventi";
  final List<List> news = [
    ["Nuova Apertura", "12/02/12", "assets/images/news.jpg"],
    ["Mostra a Palazzo della Nuova", "21/02/13", "assets/images/news1.jpg"],
  ];
  final List<List> eventi = [
    ["Nuova Apertura", "12/02/12", "assets/images/eventi.jpg"],
    ["Mostra a Palazzo della Nuova", "21/02/13", "assets/images/eventi1.jpg"],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventi"),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          CarouselSlider(
            items: news
                .map(
                  (infos) => new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(infos[2]), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            infos[0],
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BorderedText(
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
            height: 35,
          ),
          CarouselSlider(
            items: eventi
                .map(
                  (infos) => new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(infos[2]), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            infos[0],
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BorderedText(
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
        ],
      ),
    );
  }
}
