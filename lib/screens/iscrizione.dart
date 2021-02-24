import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:fdmApp/screens/iscrizione/iscrizione2.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../authentication_service.dart';
import 'home/mainDrawer.dart';
import 'iscrizione/DatiAccount.dart';

class Iscrizione extends StatefulWidget {
  static const String routeName = "/iscrizione";

  @override
  _IscrizioneState createState() => _IscrizioneState();
}

class _IscrizioneState extends State<Iscrizione> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _intestationController = TextEditingController();
  final _provenienceController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _capController = TextEditingController();
  final _messaggioController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //check if the date is close to the end of the year and if true -->
  //report an alert that validity of the tickets will be so short

  Map data = {};
  String emailResponsabile;
  Map lista = {
    "One": "Singolo - €15/anno",
    "Two": "Familiare - €30/anno",
    "Three": "Gruppo - €50/anno",
  };
  Map groupList = {
    "Singolo - €15/anno": "Singolo",
    "Familiare - €30/anno": "Familiare",
    "Gruppo - €50/anno": "Gruppo",
  };
  Map prezzi = {
    "Singolo": "1500",
    "Familiare": "3000",
    "Gruppo": "5000",
  };
  List<String> elementi = [
    "One",
    "Two",
    "Three",
  ];
  final List<String> elementiSigle = [
    'AG',
    'AL',
    'AN',
    'AR',
    'AP',
    'AT',
    'AV',
    'BA',
    'BT',
    'BL',
    'BN',
    'BG',
    'BI',
    'BO',
    'BZ',
    'BS',
    'BR',
    'CA',
    'CL',
    'CB',
    'CI',
    'CE',
    'CT',
    'CZ',
    'CH',
    'CO',
    'CS',
    'CR',
    'KR',
    'CN',
    'EN',
    'FM',
    'FE',
    'FI',
    'FG',
    'FC',
    'FR',
    'GE',
    'GO',
    'GR',
    'IM',
    'IS',
    'AQ',
    'SP',
    'LT',
    'LE',
    'LC',
    'LI',
    'LO',
    'LU',
    'MC',
    'MN',
    'MS',
    'MT',
    'VS',
    'ME',
    'MI',
    'MO',
    'MB',
    'NA',
    'NO',
    'NU',
    'OG',
    'OT',
    'OR',
    'PD',
    'PA',
    'PR',
    'PV',
    'PG',
    'PU',
    'PE',
    'PC',
    'PI',
    'PT',
    'PN',
    'PZ',
    'PO',
    'RG',
    'RA',
    'RC',
    'RE',
    'RI',
    'RN',
    'RM',
    'RO',
    'SA',
    'SS',
    'SV',
    'SI',
    'SR',
    'SO',
    'TA',
    'TE',
    'TR',
    'TO',
    'TP',
    'TN',
    'TV',
    'TS',
    'UD',
    'AO',
    'VA',
    'VE',
    'VB',
    'VC',
    'VR',
    'VV',
    'VI',
    'VT',
  ];
  String provinceValue = "AG";
  String dropdownValue = "One";
  String groupType;
  bool checked = false;
  bool check = false;
  String verifyResult = "";
  final Map province = {
    'AG': 'Agrigento',
    'AL': 'Alessandria',
    'AN': 'Ancona',
    'AR': 'Arezzo',
    'AP': 'Ascoli Piceno',
    'AT': 'Asti',
    'AV': 'Avellino',
    'BA': 'Bari',
    'BT': 'Barletta-Andria-Trani',
    'BL': 'Belluno',
    'BN': 'Benevento',
    'BG': 'Bergamo',
    'BI': 'Biella',
    'BO': 'Bologna',
    'BZ': 'Bolzano/Bozen',
    'BS': 'Brescia',
    'BR': 'Brindisi',
    'CA': 'Cagliari',
    'CL': 'Caltanissetta',
    'CB': 'Campobasso',
    'CI': 'Carbonia-Iglesias',
    'CE': 'Caserta',
    'CT': 'Catania',
    'CZ': 'Catanzaro',
    'CH': 'Chieti',
    'CO': 'Como',
    'CS': 'Cosenza',
    'CR': 'Cremona',
    'KR': 'Crotone',
    'CN': 'Cuneo',
    'EN': 'Enna',
    'FM': 'Fermo',
    'FE': 'Ferrara',
    'FI': 'Firenze',
    'FG': 'Foggia',
    'FC': 'Forlì-Cesena',
    'FR': 'Frosinone',
    'GE': 'Genova',
    'GO': 'Gorizia',
    'GR': 'Grosseto',
    'IM': 'Imperia',
    'IS': 'Isernia',
    'AQ': "L'Aquila",
    'SP': 'La Spezia',
    'LT': 'Latina',
    'LE': 'Lecce',
    'LC': 'Lecco',
    'LI': 'Livorno',
    'LO': 'Lodi',
    'LU': 'Lucca',
    'MC': 'Macerata',
    'MN': 'Mantova',
    'MS': 'Massa-Carrara',
    'MT': 'Matera',
    'VS': 'Medio Campidano',
    'ME': 'Messina',
    'MI': 'Milano',
    'MO': 'Modena',
    'MB': 'Monza-Brianza',
    'NA': 'Napoli',
    'NO': 'Novara',
    'NU': 'Nuoro',
    'OG': 'Ogliastra',
    'OT': 'Olbia-Tempio',
    'OR': 'Oristano',
    'PD': 'Padova',
    'PA': 'Palermo',
    'PR': 'Parma',
    'PV': 'Pavia',
    'PG': 'Perugia',
    'PU': 'Pesaro-Urbino',
    'PE': 'Pescara',
    'PC': 'Piacenza',
    'PI': 'Pisa',
    'PT': 'Pistoia',
    'PN': 'Pordenone',
    'PZ': 'Potenza',
    'PO': 'Prato',
    'RG': 'Ragusa',
    'RA': 'Ravenna',
    'RC': 'Reggio Calabria',
    'RE': "Reggio Emilia",
    'RI': 'Rieti',
    'RN': 'Rimini',
    'RM': 'Roma',
    'RO': 'Rovigo',
    'SA': 'Salerno',
    'SS': 'Sassari',
    'SV': 'Savona',
    'SI': 'Siena',
    'SR': 'Siracusa',
    'SO': 'Sondrio',
    'TA': 'Taranto',
    'TE': 'Teramo',
    'TR': 'Terni',
    'TO': 'Torino',
    'TP': 'Trapani',
    'TN': 'Trento',
    'TV': 'Treviso',
    'TS': 'Trieste',
    'UD': 'Udine',
    'AO': "Aosta",
    'VA': 'Varese',
    'VE': 'Venezia',
    'VB': 'Verbano-Cusio-Ossola',
    'VC': 'Vercelli',
    'VR': 'Verona',
    'VV': 'Vibo Valentia',
    'VI': 'Vicenza',
    'VT': 'Viterbo'
  };

  String simplePhoneValidator(value) {
    if (value.isEmpty) {
      return "Dati Mancanti";
    }
    data["telefono"] = value;
    return null;
  }

  Future<bool> isEmailExisting(String email) async {
    var result = await context.read<AuthenticationService>().signIn(
          email: email.trim(),
          password: "invalida",
        );
    if (Platform.isAndroid) {
      if (result ==
          'The password is invalid or the user does not have a password.') {
        return true;
      } else {
        return false;
      }
    } else {
      if (result == 'Error 17009') {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Diventa Socio",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Utilizzo()));
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Completa i Campi",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 360,
                  height: (MediaQuery.of(context).size.height) / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: Offset(0, 3),
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
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _intestationController,
                              decoration: const InputDecoration(
                                hintText: "Inserire il nome del gruppo",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Intestazione per Gruppi",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  data["intestazione gruppo"] = "Nessuna";
                                  return null;
                                }
                                data["intestazione gruppo"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                hintText: "Inserire il Nome",
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Nome",
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
                                data["nome"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _surnameController,
                              decoration: const InputDecoration(
                                hintText: "Inserire il Cognome",
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Cognome",
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
                                data["cognome"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _provenienceController,
                              decoration: const InputDecoration(
                                hintText: "Inserire l'indirizzo",
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
                            TextFormField(
                              controller: _cityController,
                              decoration: const InputDecoration(
                                hintText: "Inserire la città",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Città",
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
                                data["città"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _capController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Inserire il CAP",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "CAP",
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
                                data["CAP"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              isDense: true,
                              value: provinceValue,
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
                                  provinceValue = newValue;
                                  data["provincia"] = newValue;
                                  print(data["provincia"]);
                                });
                              },
                              items: elementiSigle
                                  .map((value) => new DropdownMenuItem(
                                        value: value,
                                        child: Text(province[value]),
                                      ))
                                  .toList(),
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
                              validator: simplePhoneValidator,
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
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                hintText: "Scegliere un username",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Username",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Dati Mancanti";
                                } else if (value.length > 25) {
                                  return "Username troppo lungo";
                                } else if (value.length < 5) {
                                  return "Username troppo corto";
                                }
                                data["username"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                hintText: "Scegliere una password",
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
                                } else if (value.length > 25) {
                                  return "Password troppo lunga";
                                } else if (value.length < 5) {
                                  return "Password troppo corta";
                                }
                                data["password"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
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
                                  String group = lista[newValue];
                                  groupType = groupList[group];
                                  data["tipo di gruppo"] = groupType;
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
                              height: 15,
                            ),
                            TextFormField(
                              controller: _messaggioController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 15,
                              decoration: const InputDecoration(
                                hintText: "Inserire un eventuale messaggio",
                                hintStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Eventuale Messaggio",
                                labelStyle: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  data["messaggio"] = "Nessun messaggio";
                                  return null;
                                }
                                data["messaggio"] = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: check
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 45, bottom: 50),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (check) {
                                                  check = false;
                                                } else {
                                                  check = true;
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
                                                if (check) {
                                                  check = false;
                                                } else {
                                                  check = true;
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
                                    "I dati saranno\n utilizzati ai sensi\n dell'art.13 del\n D.Lgs 196/2003\n e autorizzo\nil trattamento.",
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Questo è un form di raccolta dati. Controlla la nostra privacy policy per conoscere come proteggiamo e gestiamo i dati che ci fornisci.",
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
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
                                      fontSize: 24.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ButtonTheme(
                                minWidth: 150.0,
                                height: 50.0,
                                child: RaisedButton(
                                  onPressed: () async {
                                    String email = data["email"];
                                    bool emailExist =
                                        await isEmailExisting(email);
                                    if (_formKey.currentState.validate() &&
                                        checked &&
                                        check &&
                                        !emailExist) {
                                      data["prezzo"] = prezzi[groupType];
                                      if (data["prezzo"] == null) {
                                        String group = lista[dropdownValue];
                                        groupType = groupList[group];
                                        data["tipo di gruppo"] = groupType;
                                        data["prezzo"] = prezzi[groupType];
                                      }
                                      final DateFormat formatter =
                                          DateFormat('dd/MM/yyyy');
                                      String id = data["username"][0] +
                                          data["nome"][0] +
                                          data["cognome"][0] +
                                          (int.parse(formatter
                                                      .format(DateTime.now())
                                                      .replaceAll("-", "")
                                                      .replaceAll("/", "")) *
                                                  35)
                                              .toString();
                                      data["id"] = id;
                                      DatiAccount().setter(data);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PayIscrizione()));
                                    } else if (emailExist) {
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
                                              "Email già in uso!",
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
                                              "Email già in uso!!",
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
                                  child: Text(
                                    "Invia i Dati e Continua",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  color: Color.fromARGB(255, 24, 37, 102),
                                ),
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
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 100,
                  lineThickness: 3.0,
                  dashLength: 6.0,
                  dashColor: Colors.blueGrey,
                  dashGapLength: 6.0,
                  dashGapColor: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "2",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 100,
                  lineThickness: 3.0,
                  dashLength: 6.0,
                  dashColor: Colors.blueGrey,
                  dashGapLength: 6.0,
                  dashGapColor: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "3",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
