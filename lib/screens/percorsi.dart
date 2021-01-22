import 'package:bordered_text/bordered_text.dart';
import 'package:fdmApp/screens/percorsi/infoPercorso.dart';
import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Percorsi extends StatelessWidget {
  static const String routeName = "/percorsi";
  final List<List> infos = [
    [
      "Scuola",
      "assets/images/scuola.jpg",
      "La scuola di Barbiana nasce nel 1956 per i primi sei ragazzi del popolo che avevano finito la scuola elementare. Era una scuola di avviamento industriale dove don\nLorenzo Milani era insegnante unico."
    ],
    [
      "Piscina",
      "assets/images/piscina.jpg",
      "La piscina fu scavata a mano dai ragazzi con l’aiuto di qualche genitore. La volle don Lorenzo per insegnare a nuotare ai ragazzi, ma soprattutto per rompere la paura antica che i montanari hanno  della forza dell’acqua."
    ],
    [
      "Officina e Fucina",
      "assets/images/officina.jpg",
      "Per insegnare ai ragazzi a lavorare il ferro e il legno don Lorenzo attrezzò, in due stanza al piano terreno della Canonica,  l’Officina e la Fucina. Lì i ragazzi costruivano tutti gli oggetti che servivano per la scuola\ne per la casa."
    ],
    [
      "Cimitero",
      "assets/images/cimitero.jpg",
      "Qui ci sono sepolti i tre principali personaggi della storia di Barbiana: DON LORENZO MILANI, LA NONNA GIULIA E L’EDA; madre e figlia,  non abbandonarono don Lorenzo Milani e lo seguirono “nell’esilio di Barbiana”."
    ],
    [
      "Santo Scolaro",
      "assets/images/scolaro.jpg",
      "Nel 1961 don Lorenzo accompagnò i primi 6 ragazzi in una scuola di Monaco, dove si insegnava a fare mosaici di vetro. Tornati a Barbiana, decisero di decorare tutte le finestre della chiesa e della sacrestia\ncon immagini sacre."
    ],
    [
      "Ponte di Luciano",
      "assets/images/luciano.jpg",
      "Il Ponte di Luciano rimane una delle impronte lasciate dai ragazzi e Don Milani a Barbiana, simbolo della loro volontà nel creare un posto adatto ad ogni ragazzo di condizioni sociali povere di imparare."
    ],
    [
      "Sentiero della Costituzione",
      "assets/images/sentiero.jpg",
      "A Barbiana, è stato realizzato dalla Fondazione don Lorenzo Milani, il Sentiero della Costituzione. Lungo il tratto di strada nel bosco che fece don Lorenzo Milani, sono stati posti 45 grandi pannelli\nfino alla scuola di Barbiana."
    ],
    [
      "Percorso Didattico",
      "assets/images/didattico.jpg",
      "La scuola di Barbiana si sciolse nell’ottobre 1968, un anno dopo la morte di don Lorenzo, ma la canonica rimase casa di chi abitava con lui. Questo l’ha salvata dal degradarsi, mantenendo quasi intatto\nl’aspetto di quando c’era don Lorenzo."
    ],
    [
      "Mostra Fotografica",
      "assets/images/mostra.jpg",
      "Questa mostra completa il percorso didattico per il recupero degli strumenti e dei luoghi didattici originali per consentire la conoscenza dei metodi d’insegnamento seguiti da don Lorenzo nella sua\nscuola."
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Percorsi Barbiana"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: infos
                .map(
                  (i) => new Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Container(
                      width: 380,
                      height: 175,
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(i[1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              ListView(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 250,
                                        child: BorderedText(
                                          strokeWidth: 3.0,
                                          strokeColor: Colors.black,
                                          child: Text(
                                            i[0],
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: BorderedText(
                                          strokeWidth: 3.0,
                                          strokeColor: Colors.black,
                                          child: Text(
                                            i[2],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 110, right: 1),
                                    child: FloatingActionButton(
                                      heroTag: null,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, InfoPercorso.routeName,
                                            arguments: i[0]);
                                      },
                                      child: Icon(Icons.double_arrow),
                                      backgroundColor: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
