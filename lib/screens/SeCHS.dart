import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'SeCHS/InfoSeCHS.dart';
import 'eventi/InfoEvento.dart';
import 'home/mainDrawer.dart';

class Stampa extends StatelessWidget {
  static const String routeName = "/stampa";
  final List<List> news = [
    [
      "Nuova Apertura",
      "12/02/12",
      "assets/images/news.jpg",
      [
        "CONTINUA IL QUOTIDIANO IMPEGNO DELLA FONDAZIONE DON LORENZO MILANI – BARBIANA",
        "\nContinua il quotidiano impegno della Fondazione Don Lorenzo Milani nella gestione di quei luoghi e nella diffusione dell’opera e dell’esempio di don Lorenzo, affianco e in una proficua collaborazione con l’Arcidiocesi fiorentina e con il nuovo Comitato diocesano\n\nComunicato stampa//Riteniamo positiva la decisione del cardinal Betori di sottoscrivere il passaggio della chiesa e della casa canonica di Barbiana, dall’Istituto Diocesano per il Sostentamento del Clero di Firenze al patrimonio dell’Arcidiocesi di Firenze.\n\nQuesto significa che Barbiana è un luogo da tutelare, salvaguardare e difendere da ogni sfruttamento indebito e deriva turistica e che l’Arcidiocesi fiorentina si pone a garante di questo riconoscendo il prete Milani esempio per Chiesa.\n\nFin dalla sua istituzione nel 2004 la Fondazione Don Lorenzo Milani si è battuta e impegnata affinché Barbiana con la sua scuola rimanesse un luogo puro, povero e incontaminato capace ancora oggi di rinnovare la fede, scuotere le coscienze difronte alle ingiustizie sociali e proporre una scuola in cui formare l’umano. Un luogo di significato aperto a tutti coloro che trovano un punto di riferimento, civico e religioso, nel pensiero e nell’opera di don Lorenzo Milani.\n\nSu questa strada continua il quotidiano impegno della Fondazione Don Lorenzo Milani nella gestione di quei luoghi e nella diffusione dell’opera e dell’esempio di don Lorenzo, affianco e in una proficua collaborazione con l’Arcidiocesi fiorentina e con il nuovo Comitato diocesano, che ha riconosciuto il ruolo della Fondazione e «di aver mantenuto Barbiana nella sua semplice povertà, così come la lasciò il Priore alla sua morte, proposta a tutti come luogo della testimonianza, della riflessione e del confronto con la memoria di don Milani, evitando cedimenti a derive turistiche e celebrative. Un impegno che l’Arcidiocesi condivide e intende ribadire».\n\nIn questo passaggio vogliamo ricordare l’opera di Michele Gesualdi e Giancarlo Carotti che hanno curato e tutelato i luoghi di Barbiana e la memoria del loro Priore per tutta la vita.\n\nE un ringraziamento a tutti i volontari e sostenitori.\n\nFirenze, 2/1/21",
        "",
        "",
        "",
        "",
      ],
    ],
    [
      "Mostra a Palazzo della Nuova",
      "21/02/13",
      "assets/images/news1.jpg",
      [
        "ANNIVERSARIO DELL’ARRIVO A BARBIANA DI DON LORENZO – 7 DICEMBRE 1954",
        "\nEsattamente 66 anni fa don Lorenzo arrivava a Barbiana per la prima volta. Era l’inizio di una storia che continua ancora oggi, un inizio difficile, come ha raccontato Michele Gesualdi nel suo libro Don Lorenzo Milani. L’esilio di Barbiana:\nNei pressi di Vicchio il camioncino si guastò e fu costretto a fermarsi per essere riparato. Don Lorenzo, che voleva arrivare di giorno a Barbiana, proseguì da solo facendosi accompagnare con una macchina che svolgeva servizio pubblico. L’auto salì per quella strada sconnessa e sterrata fino a quando si trasformò in un sentiero e don Lorenzo dovette continuare a piedi la ricerca della sua nuova chiesa. Intorno a sé niente, solo silenzio e bosco. Sa bene che in quel niente tutto deve rinascere ripartendo da capo. «Se faccio fiasco anche lassù», aveva scritto a don Rossi, «non mi resterà che farmi monaco, di quelli murati vivi per salvarmi almeno l’anima». Mentre cammina verso la sua chiesa lotta in solitudine con la coscienza. Nel frattempo il cielo si oscura e si scatena un violento temporale. Arrivò che era quasi buio, bagnato e infreddolito. Non c’era nessuno ad accoglierlo. Entrò in chiesa, si inginocchiò nell’ultima panca vicino alla porta, pregò con la testa fra le mani. Il lume delle poche candele facevano a malapena intravedere le sagome del parroco uscente che dall’altare recitava la novena per la Madonna. Alla funzione erano presenti solo tre donne e due ragazzetti. Tra le tre donne l’Eda e la Giulia che erano arrivate la mattina. Dei due ragazzetti uno era il nipote del prete uscente e l’altro Agostino, uno dei primi sei ragazzi per i quali don Lorenzo organizzerà la scuola di Barbiana in canonica. Pregò per tutto il tempo della novena. Quando si rialzò era già un uomo diverso. Diverso dal ricco benefattore dei poveri, diverso dallo stesso Cappellano di San Donato.\nCome Giacobbe, aveva vinto la lotta con l’Angelo, ma ne era uscito sciancato. Ora è l’uomo che ha intrapreso il cammino che lo porterà ad essere povero tra i poveri. Nella solitudine e nel silenzio di quei monti ricomincia il suo cammino pastorale per la elevazione umana, sociale e religiosa di quelle poche creature che ancora erano rimaste nella parrocchia di Sant’Andrea a Barbiana. La mattina dopo un carro senza ruote, trainato a strascico, tipo slitta, da due buoi di un contadino, andò a recuperare la mobilia che il camioncino aveva scaricato ai piedi della mulattiera, in fondo alla salita. Purtroppo il temporale della sera prima aveva rovinato tutto. Era rimasta solo roba fradicia e pezzi di mobili scollati e galleggianti nelle pozzanghere d’acqua. Aveva perso tutto.",
        "",
        "",
        "",
        "",
      ],
    ],
  ];
  final List<List> eventi = [
    [
      "Nuove Aperture",
      "15/04/14",
      "assets/images/eventi.jpg",
      [
        "ARCIDOSSO GR 16 OTTOBRE 2018 PROGETTO ” UN LIBRO-UN SEME”SCUOLA DI BARBIANA, LETTERA A UNA PROFESSORESSA",
        "L’inaugurazione della Mostra, che rimarrà allestita al castello Aldobrandesco fino al 21 ottobre, nelle intenzioni del progetto è l’avvio di un percorso proposto agli Istituti Superiori di Arcidosso, in particolare agli studenti, attorno ad alcune parole chiave che gli studenti stessi, coadiuvati dai loro docenti individueranno nel testo della scuola di Barbiana Lettera a una Professoressa. Libro-seme perché nel mutamento profondo dei tempi e delle culture, le sue pagine non cessano di provocare.",
        "",
        "",
        "",
        "",
      ],
    ],
    [
      "Mostre a Palazzo della Nuova",
      "22/12/21",
      "assets/images/eventi1.jpg",
      [
        "La scuola popolare di Sesto Fiorentino",
        "\nIl libro “La scuola popolare di Sesto Fiorentino” di Piero Bosi e Sandra Nistri sarà presentato il 24 luglio pv alle 21 alla Festa Sociale di Carraia in corso nel campo sportivo della frazione di Carraia a Calenzano.",
        "",
        "",
        "",
        "",
      ],
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stampa e Ci Hanno Scritto"),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          CarouselSlider(
            items: news
                .map((infos) => new Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(infos[2]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              BorderedText(
                                strokeWidth: 3.0,
                                strokeColor: Colors.black,
                                child: Text(
                                  infos[0],
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              BorderedText(
                                strokeWidth: 3.0,
                                strokeColor: Colors.black,
                                child: Text(
                                  infos[1],
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FloatingActionButton(
                                    heroTag: null,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, InfoSeCHS.routeName,
                                          arguments: infos);
                                    },
                                    child: Icon(
                                      Icons.double_arrow,
                                      size: 45,
                                    ),
                                    backgroundColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200.0,
                aspectRatio: 4 / 3,
                enableInfiniteScroll: true,
                viewportFraction: 0.8),
          ),
          SizedBox(
            height: 35,
          ),
          CarouselSlider(
            items: eventi
                .map(
                  (infos) => new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(infos[2]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            BorderedText(
                              strokeWidth: 3.0,
                              strokeColor: Colors.black,
                              child: Text(
                                infos[0],
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            BorderedText(
                              strokeWidth: 3.0,
                              strokeColor: Colors.black,
                              child: Text(
                                infos[1],
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FloatingActionButton(
                                  heroTag: null,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, InfoSeCHS.routeName,
                                        arguments: infos);
                                  },
                                  child: Icon(
                                    Icons.double_arrow,
                                    size: 45,
                                  ),
                                  backgroundColor: Colors.blueGrey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200.0,
                aspectRatio: 4 / 3,
                enableInfiniteScroll: true,
                viewportFraction: 0.8),
          ),
        ],
      ),
    );
  }
}
