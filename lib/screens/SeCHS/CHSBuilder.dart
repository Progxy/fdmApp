import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fdmApp/screens/SeCHS/InfoSeCHS.dart';
import 'package:fdmApp/screens/databaseManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CHSBuilder extends StatefulWidget {
  CHSBuilder({this.app});
  final FirebaseApp app;

  @override
  _CHSBuilderState createState() => _CHSBuilderState();
}

class _CHSBuilderState extends State<CHSBuilder> {
  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    List data = [];
    getData(FirebaseDatabase database) async {
      List general = await DatabaseManager().getSeCHS(database);
      data = general[1].toList();
    }

    return FutureBuilder(
        future: getData(database),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return CarouselSlider(
            items: data
                .map(
                  (infos) => new Container(
                    height: 225,
                    width: 360,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          infos[2].replaceAll('"', ''),
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
                                infos[0],
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
                                      Navigator.pushNamed(
                                          context, InfoSeCHS.routeName,
                                          arguments: infos);
                                    },
                                    child: Icon(
                                      Icons.double_arrow,
                                      size: 45,
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 24, 37, 102),
                                  ),
                                ),
                              ],
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
          );
        });
  }
}
