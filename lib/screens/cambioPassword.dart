import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/authentication_service.dart';
import 'package:fdmApp/screens/IscrizioneScaduta.dart';
import 'package:fdmApp/screens/VerifyExpiration.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

import 'badConnection.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';
import 'login.dart';

class CambioPassword extends StatefulWidget {
  static const String routeName = "/cambiopassword";
  CambioPassword({this.app});
  final FirebaseApp app;

  @override
  _CambioPasswordState createState() => _CambioPasswordState();
}

class _CambioPasswordState extends State<CambioPassword> {
  changePassword(String emails, String password, String oldpassword,
      FirebaseDatabase database) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Caricamento...');
    await dialog.show();
    context.read<AuthenticationService>().signOut();
    bool isLogged;
    final log = FirebaseAuth.instance.currentUser;
    log != null ? isLogged = true : isLogged = false;
    if (isLogged == false) {
      await context.read<AuthenticationService>().signIn(
            email: emails.trim(),
            password: oldpassword.trim(),
          );
      final bool isExpired = await VerifyExpiration().verify(database);
      if (isExpired) {
        context.read<AuthenticationService>().signOut();
        await dialog.hide();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IscrizioneScaduta()));
        return null;
      }
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updatePassword(password).then((_) async {
        database
            .reference()
            .child(user.uid)
            .child("Pass")
            .set({password: email});
        String id = await getId(user.uid, database);
        await updateDbManager(id, password);
        await dialog.hide();
        context.read<AuthenticationService>().signOut();
        if (Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 50,
              ),
              content: Text(
                "Password cambiata con successo!",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  onPressed: () {
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
              title: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 50,
              ),
              content: Text(
                "Password cambiata con successo!",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                )
              ],
            ),
          );
        }
      }).catchError((error) async {
        await dialog.hide();
        context.read<AuthenticationService>().signOut();
        print("\n-\nerror : $error\n-\n");
        if (Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              content: Text(
                "Non è stato possibile cambiare la password!",
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
                    Navigator.of(context, rootNavigator: true).pop('dialog');
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
              title: Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              content: Text(
                "Non è stato possibile cambiare la password!",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                )
              ],
            ),
          );
        }
      });
    } else {
      await dialog.hide();
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            content: Text(
              "Non è stato trovato nessun account con le credenziali fornite!",
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
                  Navigator.of(context, rootNavigator: true).pop('dialog');
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
            title: Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            content: Text(
              "Non è stato trovato nessun account con le credenziali fornite!",
              style: TextStyle(
                fontSize: 27,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              )
            ],
          ),
        );
      }
    }
  }

  updateDbManager(String id, String newPass) async {
    final String fdbUrl2 =
        "https://fdmmanager-2fef4-default-rtdb.firebaseio.com/";
    final secondaryDb = FirebaseDatabase(databaseURL: fdbUrl2).reference();
    try {
      secondaryDb.child("Tessere/" + id).update({"password": newPass});
      return true;
    } catch (e) {
      return false;
    }
  }

  getId(String uid, FirebaseDatabase database) async {
    String id = "";
    await database
        .reference()
        .child(uid)
        .child("Id")
        .once()
        .then((DataSnapshot snapshot) {
      var valId = snapshot.value;
      var idCopy = valId.keys.toList()[0];
      id = idCopy;
    });
    return id;
  }

  final List<String> choices = <String>[
    "FeedBack",
    "Aiuto",
  ];
  void choiceAction(String choice) async {
    if (choice == "Aiuto") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Utilizzo()));
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BadConnection()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedBack()));
      }
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _oldpasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  String email;
  String oldPassword;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Cambio Password",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList();
            },
          )
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15),
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
                controller: _oldpasswordController,
                decoration: const InputDecoration(
                  hintText: "Inserire la vecchia password",
                  hintStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Vecchia Password",
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
                  oldPassword = value;
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Inserire la nuova password",
                  hintStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Nuova Password",
                  labelStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Dati Mancanti";
                  } else if (value != _confirmpasswordController.text.trim()) {
                    return "Le Password Sono Diverse";
                  } else if (value == _oldpasswordController.text.trim()) {
                    return "La Password è Uguale a Quella Precedente";
                  } else if (value.length > 25) {
                    return "Password troppo lunga";
                  } else if (value.length < 5) {
                    return "Password troppo corta";
                  }
                  password = value;
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _confirmpasswordController,
                decoration: const InputDecoration(
                  hintText: "Confermare la nuova password",
                  hintStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Conferma Password",
                  labelStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Dati Mancanti";
                  } else if (value != _passwordController.text.trim()) {
                    return "Le Password Sono Diverse";
                  }
                  confirmPassword = value;
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonTheme(
                  minWidth: 150.0,
                  height: 50.0,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 24, 37, 102),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        changePassword(email, password, oldPassword, database);
                      } else {
                        if (isIOS) {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50,
                              ),
                              content: Text(
                                "Ricompilare il campo come indicato!",
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
                              title: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50,
                              ),
                              content: Text(
                                "Ricompilare il campo come indicato!",
                                style: TextStyle(
                                  fontSize: 27,
                                ),
                              ),
                              actions: [
                                TextButton(
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
                      "Cambia Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Image(
                image: AssetImage("assets/images/don_milani.png"),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
