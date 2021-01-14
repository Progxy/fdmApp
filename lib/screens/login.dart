import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdmApp/authentication_service.dart';
import 'package:fdmApp/screens/login/userpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'home/accountInfo.dart';
import 'home/mainDrawer.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email;
  String user;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return UserPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Inserire l'email",
                hintStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              validator: (value) {
                String _emailPattern =
                    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
                bool isValid(String pattern, String input) =>
                    RegExp(pattern).hasMatch(input);
                if (value == null) {
                  return "Dati Mancanti";
                } else if (isValid(_emailPattern, value) == false) {
                  return "Email Errata";
                }
                email = value;
                return null;
              },
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Inserire la password",
                hintStyle: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
                labelText: "Password",
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
                user = value;
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    context.read<AuthenticationService>().signIn(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                    if (firebaseUser != null) {
                      FutureBuilder<DocumentSnapshot>(
                        future: users.doc(email).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            if (isIOS) {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                    )
                                  ],
                                ),
                              );
                            }
                            return null;
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data = snapshot.data.data();
                            AccountInfo().setter(data["name"], email);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserPage()));
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
                      if (isIOS) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: Text(
                              "Errore",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            content: Text(
                              "Email o Password invalida!",
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
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
                              "Email o Password invalida!",
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                              )
                            ],
                          ),
                        );
                      }
                    }
                  } else {
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
                            "Email o Password mancanti!",
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
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
                            "Email o Password mancanti!",
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                            )
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Image(
              image: AssetImage("assets/images/don_milani.png"),
              fit: BoxFit.cover,
            ),
          ],
        ),
      )),
    );
  }
}
