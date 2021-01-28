import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mailer2/mailer.dart';
import 'package:intl/intl.dart';

import 'databaseManager.dart';
import 'home.dart';
import 'home/mainDrawer.dart';
import 'visita/disponibilità.dart';

class Visita extends StatefulWidget {
  static const String routeName = "/visita";

  Visita({this.app});
  final FirebaseApp app;

  @override
  _VisitaState createState() => _VisitaState();
}

class _VisitaState extends State<Visita> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _groupController = TextEditingController();
  final _sizeController = TextEditingController();
  final _provenienceController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _responsabilePhoneController = TextEditingController();
  final _emailResponsabileController = TextEditingController();
  final _conoscenzaController = TextEditingController();
  final _preparazioneController = TextEditingController();
  final _richiesteController = TextEditingController();
  final _dateController = TextEditingController();
  Map data = {};
  String emailResponsabile;
  Map lista = {
    "One": "Scolastico",
    "Two": "Parrocchiale",
    "Three": "Scout",
    "Four": "Altro",
  };
  List<String> elementi = ["One", "Two", "Three", "Four"];
  String dropdownValue = "One";
  String groupType;
  bool checked = false;
  String verifyResult = "";
  final format = DateFormat("dd/MM/yyyy HH:mm");

  String simplePhoneValidator(value) {
    if (value.isEmpty) {
      return "Dati Mancanti";
    }
    data["telefono"] = value;
    return null;
  }

  String simpleResponsabilePhoneValidator(value) {
    if (value.isEmpty) {
      return "Dati Mancanti";
    }
    data["telefono responsabile"] = value;
    return null;
  }

  String simpleSizeValidator(value) {
    if (value.isEmpty) {
      return "Dati Mancanti";
    } else if (int.parse(value) >= 101 || int.parse(value) <= 0) {
      return "Gruppo Troppo Numeroso";
    }
    data["numero del gruppo"] = value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    List datas = [];
    getData(FirebaseDatabase database) async {
      datas = await DatabaseManager().getDisponibilita(database);
    }

    sendData(Map datas) async {
      var options = new GmailSmtpOptions()
        ..username = 'ermes.express.fdm@gmail.com'
        ..password = 'CASTELLO1967';

      var emailTransport = new SmtpTransport(options);

      String emailBody = "";

      String email = datas["email"];
      String giorno = datas["giorno"];

      datas.forEach((k, v) => emailBody += "$k: $v\n");

      var envelope = new Envelope()
        ..from = 'ermes.express.fdm@gmail.com'
        ..recipients.add('eossmario@gmail.com') //utilizza account per visite
        ..subject = 'Info Visita'
        ..text = "Info Visita:\n" + emailBody + "\n\nErmes-Express FDM";

      var mail = new Envelope()
        ..from = 'ermes.express.fdm@gmail.com'
        ..recipients.add(email)
        ..subject = 'Conferma Visita'
        ..text =
            "Le Confermiamo la prenotazione della sua visita: prevista per il giorno $giorno.\n\nErmes-Express FDM";

      if (isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(
              "Caricamento...",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              "Caricamento...",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      await emailTransport.send(envelope).then((envelope) async {
        await emailTransport.send(mail).then((mail) {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          if (isIOS) {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(
                  "Grazie per la Prenotazione!",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                content: Text(
                  "Provvederemo a prendere in esame la prenotazione.\nLa Fondazione Don Milani.",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Text(
                      "Vai alla HomePage",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
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
                  "Grazie per la Prenotazione!",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                content: Text(
                  "Provvederemo a prendere in esame la prenotazione.\nLa Fondazione Don Milani.",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Text(
                      "Vai alla HomePage",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }).catchError((e) {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          print(e);
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
                  "Ops... Qualcosa è andato storto!\nNon è stato possibile inviare la email!",
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
                title: Text(
                  "Errore",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                content: Text(
                  "Ops... Qualcosa è andato storto!\nNon è stato possibile inviare la email!",
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
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  )
                ],
              ),
            );
          }
        });
      }).catchError((e) {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        print(e);
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
                "Ops... Qualcosa è andato storto!\nNon è stato possibile inviare la email!",
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
              title: Text(
                "Errore",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              content: Text(
                "Ops... Qualcosa è andato storto!\nNon è stato possibile inviare la email!",
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
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                )
              ],
            ),
          );
        }
      });
    }

    bool _predicate(DateTime day) {
      int validTimes;
      for (var elements in datas) {
        if (day.compareTo(elements[0]) == 0) {
          validTimes = 0;
          break;
        } else {
          validTimes = 1;
        }
      }
      if (validTimes != 0) {
        return false;
      } else {
        return true;
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Visita Barbiana"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Disponibilita()));
                    },
                    label: Text(
                      "Verifica Disponibilità",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 360,
                  height: 430,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            DateTimeField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: "Data Visita (8:00 - 17:30)",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              format: format,
                              onShowPicker: (context, currentValue) async {
                                await getData(database);
                                int ind = 0;
                                for (var elem in datas) {
                                  DateFormat inputDateFormat =
                                      new DateFormat("dd-MM-yyyy");
                                  DateFormat outputDateFormat =
                                      new DateFormat("yyyy-MM-dd");
                                  String dates = outputDateFormat
                                      .format(inputDateFormat.parse(elem[0]));
                                  var date = DateTime.parse(dates);
                                  datas[ind][0] = date;
                                  ind++;
                                }
                                datas.sort((a, b) {
                                  var adate = a[0];
                                  var bdate = b[0];
                                  return -adate.compareTo(bdate);
                                });
                                final date = await showDatePicker(
                                    context: context,
                                    selectableDayPredicate: _predicate,
                                    firstDate: datas.last[0],
                                    initialDate:
                                        datas.last[0] ?? DateTime.now(),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData(
                                            primaryColor: Colors.blueGrey,
                                            disabledColor: Colors.grey,
                                            textTheme: TextTheme(
                                              headline1: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            accentColor: Colors.blueGrey),
                                        child: child,
                                      );
                                    });

                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                              validator: (value) {
                                int validTime;
                                if (value == null) {
                                  return "Dati Mancanti";
                                } else {
                                  final DateFormat formatter =
                                      DateFormat('dd/MM/yyyy');
                                  final DateFormat formatters =
                                      DateFormat('dd/MM/yyyy HH:mm');
                                  for (var element in datas) {
                                    if (formatter.format(value) ==
                                        formatter.format(element[0])) {
                                      validTime = 0;
                                      break;
                                    } else {
                                      validTime = 1;
                                    }
                                  }
                                  if (validTime != 0) {
                                    return "Data Non Disponibile";
                                  } else {
                                    data["giorno"] = formatters.format(value);
                                    return null;
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
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
                                } else if (isValid(_emailPattern, value) ==
                                    false) {
                                  return "Email Errata";
                                }
                                data["email"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _groupController,
                              decoration: const InputDecoration(
                                hintText: "Inserire il nome del gruppo",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Nome del Gruppo",
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
                                data["gruppo"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _sizeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText:
                                    "Inserire il numero di persone( max. 100 pax)",
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Grandezza del Gruppo",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: simpleSizeValidator,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _provenienceController,
                              decoration: const InputDecoration(
                                hintText: "Inserire la località di provenienza",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Provenienza",
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
                                data["provenienza"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _locationController,
                              decoration: const InputDecoration(
                                hintText: "Inserire l'indirizzo'",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Indirizzo",
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
                                data["indirizzo"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            IntlPhoneField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                hintText: "Inserire il telefono",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Telefono",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              initialCountryCode: 'IT',
                              validator: simpleResponsabilePhoneValidator,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                hintText:
                                    "Inserire nome e cognome del responsabile",
                                hintStyle: TextStyle(
                                  fontSize: 16.7,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Nome e Cognome",
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
                                data["nome responsabile"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            IntlPhoneField(
                              controller: _responsabilePhoneController,
                              decoration: InputDecoration(
                                hintText:
                                    "Inserire il telefono del responsabile",
                                hintStyle: TextStyle(
                                  fontSize: 13.4,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Telefono Responsabile",
                                labelStyle: TextStyle(
                                  fontSize: 20.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              initialCountryCode: 'IT',
                              validator: simplePhoneValidator,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _emailResponsabileController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Inserire l'email del responsabile",
                                hintStyle: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Email Responsabile",
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
                                } else if (isValid(_emailPattern, value) ==
                                    false) {
                                  return "Email Errata";
                                }
                                data["email del responsabile"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              isDense: true,
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 40,
                              elevation: 20,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  groupType = lista[newValue];
                                });
                              },
                              items: elementi
                                  .map((value) => new DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(lista[value]),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onTap: () {
                                showerInfoSnackBar(
                                    "Per permettere a chi della Fondazione accoglierà il gruppo, preghiamo di descrivere cosa si conosce di Don Milani, dei suoi scritti e della scuola di Barbiana");
                              },
                              controller: _conoscenzaController,
                              maxLines: 15,
                              decoration: const InputDecoration(
                                hintText:
                                    "Inserire il livello di Conoscenza di Don Lorenzo Milani",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Conoscenza",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  data["conoscenze"] = "Nessuna conoscenza";
                                  return null;
                                }
                                data["conoscenze"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              onTap: () {
                                showerInfoSnackBar(
                                    "Indicateci i dettagli dell'eventuale lavoro di preparazione alla visita che è stato fatto");
                              },
                              controller: _preparazioneController,
                              maxLines: 15,
                              decoration: const InputDecoration(
                                hintText: "Inserire il Lavoro di Preparazione",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Preparazione",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  data["preparazione"] =
                                      "Nessuna preparazione.";
                                  return null;
                                }
                                data["preparazione"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onTap: () {
                                showerInfoSnackBar(
                                    "Cosa vorreste fosse in particolar modo approfondito durante l'incontro a Barbiana ?");
                              },
                              controller: _richiesteController,
                              maxLines: 15,
                              decoration: const InputDecoration(
                                hintText: "Inserire eventuali Richieste",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Richieste",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  data["richieste"] = "Nessuna richiesta.";
                                  return null;
                                }
                                data["richieste"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Questo è un form di raccolta dati. Controlla la nostra privacy policy per conoscere come proteggiamo e gestiamo i dati che ci fornisci.",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: checked
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 45, bottom: 50),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (checked) {
                                                  checked = false;
                                                } else {
                                                  checked = true;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 65,
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 17,
                                            right: 5,
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                if (checked) {
                                                  checked = false;
                                                } else {
                                                  checked = true;
                                                }
                                              });
                                            },
                                            color: Colors.red,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              size: 35,
                                            ),
                                            padding: EdgeInsets.all(10),
                                            shape: CircleBorder(),
                                          ),
                                        ),
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    "Utilizzando questo\n form, acconsenti\n al salvataggio\n ed alla gestione\n dei tuoi dati su\n questa applicazione.",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FloatingActionButton(
                              heroTag: null,
                              backgroundColor: Colors.blueGrey,
                              onPressed: () {
                                if (_formKey.currentState.validate() &&
                                    checked) {
                                  data["tipo di gruppo"] = lista[dropdownValue];
                                  sendData(data);
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
                                          "I Dati Inseriti Sono Incorretti o Mancanti!",
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
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(
                                          "Errore",
                                          style: TextStyle(
                                            fontSize: 28,
                                          ),
                                        ),
                                        content: Text(
                                          "I Dati Inseriti Sono Incorretti o Mancanti!",
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
                                }
                              },
                              child: Icon(
                                Icons.send,
                                size: 40.0,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
}
