import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdmApp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication_service.dart';
import 'home/accountInfo.dart';
import 'login/errorpage.dart';
import 'login/userpage.dart';

class AuthenticationWrapper extends StatelessWidget {
  static const String routeName = "/authentication";
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context).settings.arguments as String;
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      print("Valid User!");
      FutureBuilder<DocumentSnapshot>(
        future: users.doc(email).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            if (isIOS) {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text(
                    "Errore",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  content: Text(
                    "Errore nell'ottenere i dati dell'utente!",
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
                      onPressed: () {
                        context.read<AuthenticationService>().signOut();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    )
                  ],
                ),
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    "Errore",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  content: Text(
                    "Errore nell'ottenere i dati dell'utente!",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthenticationService>().signOut();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    )
                  ],
                ),
              );
            }
            return null;
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print(data["name"]);
            AccountInfo().setter(data["name"], email);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserPage()));
            return null;
          }
          return Center(
            child: SizedBox(
              height: 65,
              width: 65,
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
              ),
            ),
          );
        },
      );
    } else {
      return ErrorPage();
    }
    return Container();
  }
}
