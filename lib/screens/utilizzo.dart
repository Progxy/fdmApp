import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utilizzo extends StatelessWidget {
  static const String routeName = "/utilizzo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Guida all'Utilizzo",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "Benvenuto nella pagina di\nGuida all'utilizzo !",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "In questa pagina saranno mostrate tutte le funzionalità dell'applicazione attraverso semplici passaggi, illustrati con immagini!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "PERCORSI",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 37, 102),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/images/guida/percorsi_guida.png"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Nella sezione Percorsi troverete dei tondi con all'interno la descrizione di un percorso, oltre al pulsante (che è stato evidenziato) con il quale potrete recarvi nella pagina di approfondimento del percorso selezionato.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image:
                    AssetImage("assets/images/guida/percorsiInfo_guida.jpeg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Quindi vi ritroverete nella seguente schermata, che in questo caso è inerente alla scuola, dato che è stato selezionato quel pulsante.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "VISITA BARBIANA",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 37, 102),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/images/guida/formVisita_guida.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "In Visita Barbiana troverete un form da compilare (vedi immagine sopra), e un pulsante 'Verifica Disponibilità' (vedi immagine inferiore).",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image:
                    AssetImage("assets/images/guida/disponibilita_guida.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Con quest'ultimo vi potrete recare nella pagina del Calendario delle Disponibilità (vedi sotto).",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/images/guida/scegliData_guida.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Quindi sarà presente un pulsante con il quale aprirete un calendario da cui scegliere una data e verificarne lo stato.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/images/guida/datePicker_guida.jpeg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "In seguito elencherò le possibili risposte dell'applicazione : ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "1 - La data è già stata prenotata da qualche gruppo.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/images/guida/prenotata_guida.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "2 - La data è disponibile per cui vengono mostrati gli orari disponibili.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/images/guida/orari_guida.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "3 - La data non è disponibile per cui viene consigliato di scegliere nuovamente.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              child: Image(
                image:
                    AssetImage("assets/images/guida/nonDisponibile_guida.jpg"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "DISDICI VISITA",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 37, 102),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
