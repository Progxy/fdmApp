import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'home/mainDrawer.dart';

class Iscrizione extends StatefulWidget {
  static const String routeName = "/iscrizione";

  @override
  _IscrizioneState createState() => _IscrizioneState();
}

class _IscrizioneState extends State<Iscrizione> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _groupController = TextEditingController();
  final _provenienceController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _responsabilePhoneController = TextEditingController();
  final _emailResponsabileController = TextEditingController();
  final _conoscenzaController = TextEditingController();
  final _preparazioneController = TextEditingController();
  final _richiesteController = TextEditingController();
  Map data = {};
  String emailResponsabile;
  Map lista = {
    "One": "Gruppo",
    "Two": "Singolo",
    "Three": "Familiare",
  };
  List<String> elementi = [
    "One",
    "Two",
    "Three",
  ];
  String dropdownValue = "One";
  String groupType;
  bool checked = false;
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
    'FC': 'ForlÃ¬-Cesena',
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
    'MB': 'Monza e della Brianza',
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
    'PU': 'Pesaro e Urbino',
    'PE': 'Pescara',
    'PC': 'Piacenza',
    'PI': 'Pisa',
    'PT': 'Pistoia',
    'PN': 'Pordenone',
    'PZ': 'Potenza',
    'PO': 'Prato',
    'RG': 'Ragusa',
    'RA': 'Ravenna',
    'RC': 'Reggio di Calabria',
    'RE': "Reggio nell'Emilia",
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
    'AO': "Valle d'Aosta/VallÃ©e d'Aoste",
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

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Diventa Socio"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "1 - Completa i Campi",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
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
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Card(
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 10,
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
                              data["provenienza"] = value;
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
                            validator: simplePhoneValidator,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
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
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
