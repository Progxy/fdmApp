import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../InfoContent.dart';
import '../contentManager.dart';

class EventiBuilder extends StatefulWidget {
  @override
  _EventiBuilderState createState() => _EventiBuilderState();
}

class _EventiBuilderState extends State<EventiBuilder> {
  @override
  Widget build(BuildContext context) {
    generateContent() async {
      final Map contents = await ContentManager().getArticle();
      //TODO: change to getEvent();
      final List infoContents = contents.values.toList();
      List<Widget> generatedContents = [];
      for (var element in infoContents) {
        final Map infoContent = Map.from(element);
        final String title = infoContent["Title"];
        final String date = infoContent["Date"];
        final String image = infoContent["PosterImage"];
        generatedContents.add(
          Container(
            height: 225,
            width: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
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
            child: ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 35,
                    ),
                    child: BorderedText(
                      strokeWidth: 3.0,
                      strokeColor: Colors.black,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: BorderedText(
                        strokeWidth: 3.0,
                        strokeColor: Colors.black,
                        child: Text(
                          date,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5.0,
                          ),
                          child: FloatingActionButton(
                            heroTag: null,
                            onPressed: () {
                              InfoContent.isLoaded = false;
                              Navigator.pushNamed(
                                  context, InfoContent.routeName,
                                  arguments: infoContent);
                            },
                            child: Icon(
                              Icons.double_arrow,
                              size: 45,
                            ),
                            backgroundColor: Color.fromARGB(255, 24, 37, 102),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
      return generatedContents;
    }

    return FutureBuilder(
        future: generateContent(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              items: snapshot.data,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 250.0,
                  aspectRatio: 4 / 3,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
            ),
          );
        });
  }
}
