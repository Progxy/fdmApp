import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home/mainDrawer.dart';

class FeedBack extends StatefulWidget {
  static const String routeName = "/feedback";

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  double ratingValue;
  String feedBack;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _feedBackController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
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
                      ratingValue = rating;
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _feedBackController,
                maxLines: 15,
                decoration: const InputDecoration(
                  hintText: "Digitare Qui...",
                  hintStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "FeedBack",
                  labelStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Dati Mancanti";
                  }
                  feedBack = value;
                  return null;
                },
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
                        if (_formKey.currentState.validate()) {
                          CupertinoAlertDialog(
                            title: Text(
                              "Grazie per la Recensione!",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            content: Text(
                              "Provvederemo a prendere in esame i problemi ed i suggerimenti.\nLa Fondazione Don Milani.",
                              style: TextStyle(
                                fontSize: 27,
                              ),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {},
                                child: Text(
                                  "Vai alla HomePage",
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              )
                            ],
                          );
                          print(feedBack);
                          print(ratingValue);
                        } else {
                          CupertinoAlertDialog(
                            title: Text(
                              "Errore",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            content: Text(
                              "Dati Mancanti!",
                              style: TextStyle(
                                fontSize: 27,
                              ),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                onPressed: () {},
                              )
                            ],
                          );
                        }
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showerInfoSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
        height: 240.0,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      duration: Duration(seconds: 6),
    ));
  }

  void showerSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
        height: 40.0,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      duration: Duration(seconds: 4),
    ));
  }
}
