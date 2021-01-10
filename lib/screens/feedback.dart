import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home/mainDrawer.dart';

class FeedBack extends StatefulWidget {
  static const String routeName = "/feedback";

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  double rating_value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "Come Valuti l'Applicazione: ",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rating_value = rating;
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 15,
              ),
              child: Text(
                "Inserire dei Suggerimenti o dei Problemi riscontrati: ",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: Center(
              child: ButtonTheme(
                height: 43.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    print(rating_value);
                  },
                  child: Text(
                    "Invia Feedback",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
