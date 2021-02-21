import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home/mainDrawer.dart';

class Contatti extends StatelessWidget {
  static const String routeName = "/contatti";
  final List<List> links = [
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'ACLI Varese',
      'http://www.aclivarese.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'AGESCI Arezzo',
      'http://www.agesciarezzo.org/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'AGESCI TOSCANA',
      'http://www.agesci.toscana.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Associazione Don Milani di Gioiosa Jonica.',
      'http://www.donmilanigioiosa.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Associazione Guide e Scout Cattolici Italiani',
      'http://www.agesci.org/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Associazione PRO CONSUMA',
      'http://www.proconsuma.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di MANDELLO LARIO',
      'http://www.mandellolario.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di NAVE -BS-',
      'http://www.comune.nave.bs.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di SAN GIORGIO IN BOSCO -PD-',
      'http://www.comune.sangiorgioinbosco.pd.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di SAN VITTORE OLONA',
      'http://www.sanvittoreolona.org/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Cooperativa Sociale IL FIORE per un commercio equo e solidale',
      'http://ilfioreequo.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Coro Drammatico ”RENATO CONDOLEO” Direttore Paolo Bussagli',
      'http://www.cdrc.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'DALLA RETE ALLA CITTA’ DELL’UOMO Reti in Opera Salento',
      'http://www.retinoperasalento.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Editoriale DISSENSI',
      'http://www.dissensi.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Edizioni CREATIVA',
      'http://www.edizionicreativa.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'GRUPPO EREMOS Gli amici della scala di Giacobbe',
      'http://www.eremos.it/index.php?page=infoblog'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'IL TREBBO Centro di resistenza culturale: Teatro, Didattica, Scuola',
      'http://il%20trebbo/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'La Storia dei Sordomuti',
      'http://www.storiadeisordi.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'LIBRERIA EDITRICE FIORENTINA -LEF-',
      'http://www.lef.firenze.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Misericordia di Firenze ',
      'http://www.misericordia.firenze.it/Disabilita/LaVoceAmg'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Oratorio Parrocchiale di NOVELLARA',
      'http://www.novellara.net/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Parrocchia di San Martino a Vergaio -PO- MISSIONE DI PREGHIERA',
      'http://www.missionedipreghiera.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'POIEIN – Cultura, solidarieta’ e varia umanita’',
      'http://www.poiein.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Ricordando Don Carlo Zaccaro',
      'http://doncarlozaccaro.blogspot.com/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Scuola Primaria “Don Milani di NAVE -BS-',
      'http://rsb.provincia.brescia.it/ddnave/uversion/Scuola_Primaria_Don_Milani.html'
    ],
    [
      'CHIESA CATTOLICA',
      'Arcidiocesi di Gaeta',
      'http://www.arcidiocesigaeta.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'Azione Cattolica Diocesi di Gaeta',
      'http://www.azionecattolicagaeta.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'Centri Missionari dei Frati Cappuccini dell’Emilia-Romagna',
      'http://www.centromissionario.com/'
    ],
    [
      'CHIESA CATTOLICA',
      'DIOCESI di FAENZA - MODIGLIANA',
      'http://www.faenza.chiesacattolica.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'DIOCESI DI FIRENZE',
      'http://www.firenze.chiesacattolica.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'DIOCESI DI NOVARA',
      'http://www.novara.chiesacattolica.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'Diocesi di SENIGALLIA',
      'http://www.diocesisenigallia.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'Diocesi di TRIVENTO (Chieti)',
      'http://www.diocesitrivento.it/'
    ],
    [
      'LE “BARBIANA” NEL\nMONDO DI OGGI',
      'Associazione AMAN IMAN NIGER',
      'http://www.brownsea.it/harambee/niger/'
    ],
    [
      'LE “BARBIANA” NEL\nMONDO DI OGGI',
      'Associazione D.U.MA onlus',
      'http://www.dumaonlus.it/'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'ARCICONFRATERNITA’ DELLA MISERICORDIA DI FIRENZE',
      'http://www.misericordia.firenze.it/'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'Associazione NOI',
      'http://www.circolonoiferrovieri.it/'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'Giovani e Missione: PAULO FREIRE',
      'http://www.giovaniemissione.it/testimoni/paulofreire.htm'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'Progetto AGATA SMERALDA per l’adozione a distanza',
      'http://www.agatasmeralda.org/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Istituto di Istruzione Superiore SACRA FAMIGLIA di Soncino -CR-',
      'http://www.sacrafamigliasoncino.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Liceo “ALDO MORO” di Reggio Emilia',
      'http://www.liceomoro.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Liceo BERCHET Milano',
      'http://www.liceoberchet.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Pontificia Facolta’ di Scienze dell’ Educazione “AUXILIUM”',
      'http://www.pfse-auxilium.org/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Scuola Secondaria di 1^ grado “Don Lorenzo Milani” di TELVE in Valsugana -TN',
      'http://www.vecchicompagnidiscuola.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Universita’ di BOLOGNA',
      'http://www.unibo.it/'
    ],
    [
      'SINDACATI',
      'CISL Bergamo',
      'http://www.bergamo.cisl.it/',
    ],
    [
      'SINDACATI',
      'FIM-CISL -Federazione Italiana Metalmeccanici – CISL',
      'http://www.fim.cisl.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di Firenze',
      'http://www.comune.firenze.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di Vicchio del Mugello',
      'http://www.comune.vicchio.fi.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Provincia di Firenze',
      'http://www.provincia.fi.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Provincia di TRENTO',
      'http://www.provincia.tn.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Regione Toscana',
      'http://www.regione.toscana.it/'
    ],
    [
      'VARIE',
      'CENTRO DI ORIENTAMENTO SIACIALE fondato da Aldo Capitini nel 1944',
      'http://www.cosinrete.it/'
    ],
    [
      'VARIE',
      'LA MARCIA DI BARBIANA',
      'http://www.marciadibarbiana.it/',
    ],
    [
      'VARIE',
      'Libreria HERDER – ROMA',
      'http://www.herder.it/',
    ],
    [
      'VARIE',
      'URSEA; Unione rocciatori,scalatori e affini',
      'http://www.ursea.it/'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Contatti",
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
              print("ciò");
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "CONTATTI",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "\nFONDAZIONE DON LORENZO MILANI",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "\nSede Legale:\nLoc. Barbiana, 9 – 50031 Vicchio Mugello (FI)\n\nSede Operativa:\nVia Spinuci, 19 – 50141 Firenze\nTel. e Fax: 055.418811\n\nE-mail: contatti@donlorenzomilani.it\n\nE-mail in caso di malfunzionamenti: theprogxy@gmail.com",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: links
                  .map(
                    (info) => new Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/didattico.jpg"),
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
                      child: ListView(
                        children: [
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              BorderedText(
                                strokeWidth: 4.0,
                                strokeColor: Colors.black,
                                child: Text(
                                  info[0],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch(info[2]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25.0,
                                  ),
                                  child: Container(
                                    width: 300,
                                    child: BorderedText(
                                      strokeWidth: 4.0,
                                      strokeColor: Colors.blue,
                                      child: Text(
                                        info[1],
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                  )
                  .toList(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 250.0,
                  aspectRatio: 4 / 3,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8),
            ),
            SizedBox(
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}
