import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

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
  final List<List> disponibility = [
    ["12/01/2021", "Burberi Agostino"],
    ["21/10/2021", "Emanuele Burberi"],
    ["12/11/2021", "Burberi Agostino e \nBurberi Emanuele"]
  ];

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
                              final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              );
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
                                for (var element in disponibility) {
                                  if (formatter.format(value) == element[0]) {
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
