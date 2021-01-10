import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'home/mainDrawer.dart';
import 'visita/disponibilità.dart';

class Visita extends StatefulWidget {
  static const String routeName = "/visita";

  @override
  _VisitaState createState() => _VisitaState();
}

class _VisitaState extends State<Visita> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime _dateTime;
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
  Map data = {};
  String email;
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
                    padding: const EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      child: Card(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050),
                                  ).then((date) {
                                    setState(() {
                                      _dateTime = date;
                                      data["giorno"] = date;
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.date_range,
                                  size: 40.0,
                                ),
                              ),
                              Text(
                                _dateTime == null
                                    ? "Scegliere una data!"
                                    : _dateTime.toString(),
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
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
                                onSaved: (String value) {
                                  email = value;
                                },
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "Dati Mancanti"),
                                  EmailValidator(
                                      errorText: "Inserire una email valida"),
                                ]),
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
                                  hintText:
                                      "Inserire la località di provenienza",
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
                                onSaved: (String value) {
                                  emailResponsabile = value;
                                },
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "Dati Mancanti"),
                                  EmailValidator(
                                      errorText: "Inserire una email valida"),
                                ]),
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
                                    groupType = newValue;
                                  });
                                },
                                items: elementi
                                    .map(
                                        (value) => new DropdownMenuItem<String>(
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
                                    return "Dati Mancanti";
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
                                  hintText:
                                      "Inserire il Lavoro di Preparazione",
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
                                    return "Dati Mancanti";
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
                                    return "Dati Mancanti";
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
                                                  print(checked);
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
                                                  print(checked);
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
                                  Text(
                                    "Utilizzando questo\n form, acconsenti\n al salvataggio\n ed alla gestione\n dei tuoi dati su\n questa applicazione.",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate() &&
                                      checked) {
                                    showerSnackBar("Dati Inviati!");
                                    data["email"] = email;
                                    data["email responsabile"] =
                                        emailResponsabile;
                                    data["tipo di gruppo"] = groupType;
                                    print(data);
                                  } else {
                                    showerSnackBar(
                                        "I Dati Inseriti Sono Incorretti!");
                                    print(data);
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  size: 40.0,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
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
