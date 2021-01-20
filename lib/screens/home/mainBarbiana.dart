import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fdmApp/screens/databaseManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainBarbiana extends StatefulWidget {
  MainBarbiana({this.app});
  final FirebaseApp app;

  @override
  _MainBarbianaState createState() => _MainBarbianaState();
}

class _MainBarbianaState extends State<MainBarbiana> {
  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    List titles = [];
    List img = [];
    List dates = [];
    List data = [];

    return FutureBuilder(
      future: DatabaseManager().contentHomePage(database),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List general = snapshot.data;
          List informations = general[1];
          print(informations);
          informations.forEach((v) => v.forEach((k, values) => titles.add(k)));
          informations.forEach((v) => v.forEach((k, values) =>
              values.forEach((k, val) => k == "immagine" || k == "data"
                  ? k == "immagine"
                      ? img.add(val.replaceAll("\\", ""))
                      : dates.add(val)
                  : null)));
          for (var i = 0; i < titles.length; i++) {
            List tempor = [];
            tempor.add(img[i]);
            tempor.add(titles[i]);
            tempor.add(dates[i]);
            data.add(tempor);
          }
          print(data);
          return CarouselSlider(
            items: data
                .map(
                  (infos) => new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(infos[0].replaceAll('"', '')),
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
                )
                .toList(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200.0,
                aspectRatio: 4 / 3,
                enableInfiniteScroll: true,
                viewportFraction: 0.8),
          );
        }
        return CircularProgressIndicator(
          strokeWidth: 6.0,
          backgroundColor: Colors.blueGrey,
        );
      },
    );
  }
}
