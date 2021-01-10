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
      'Associazione Don\nMilani di Gioiosa Jonica.',
      'http://www.donmilanigioiosa.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Associazione Guide e\nScout Cattolici Italiani',
      'http://www.agesci.org/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Associazione PRO\nCONSUMA',
      'http://www.proconsuma.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di MANDELLO\nLARIO',
      'http://www.mandellolario.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di NAVE -BS-',
      'http://www.comune.nave.bs.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di SAN\nGIORGIO IN BOSCO -PD-',
      'http://www.comune.sangiorgioinbosco.pd.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di SAN\nVITTORE OLONA',
      'http://www.sanvittoreolona.org/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Cooperativa Sociale\nIL FIORE per un\ncommercio equo\ne solidale',
      'http://ilfioreequo.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Coro Drammatico ”\nRENATO CONDOLEO”\nDirettore Paolo Bussagli',
      'http://www.cdrc.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'DALLA RETE ALLA\nCITTA’ DELL’UOMO\nReti in Opera Salento',
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
      'GRUPPO EREMOS\nGli amici della scala\ndi Giacobbe',
      'http://www.eremos.it/index.php?page=infoblog'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'IL TREBBO\nCentro di resistenza\nculturale: Teatro,\nDidattica, Scuola',
      'http://il%20trebbo/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'La Storia dei Sordomuti',
      'http://www.storiadeisordi.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'LIBRERIA EDITRICE\nFIORENTINA -LEF-',
      'http://www.lef.firenze.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Misericordia di Firenze ',
      'http://www.misericordia.firenze.it/Disabilita/LaVoceAmg'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Oratorio Parrocchiale\ndi NOVELLARA',
      'http://www.novellara.net/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Parrocchia di San\nMartino a Vergaio\n-PO- MISSIONE\nDI PREGHIERA',
      'http://www.missionedipreghiera.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'POIEIN – Cultura,\nsolidarieta’ e varia\numanita’',
      'http://www.poiein.it/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Ricordando\nDon Carlo Zaccaro',
      'http://doncarlozaccaro.blogspot.com/'
    ],
    [
      'AMICI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Scuola Primaria\n“Don Milani di NAVE\n-BS-',
      'http://rsb.provincia.brescia.it/ddnave/uversion/Scuola_Primaria_Don_Milani.html'
    ],
    [
      'CHIESA CATTOLICA',
      'Arcidiocesi di Gaeta',
      'http://www.arcidiocesigaeta.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'Azione Cattolica\nDiocesi di Gaeta',
      'http://www.azionecattolicagaeta.it/'
    ],
    [
      'CHIESA CATTOLICA',
      'Centri Missionari dei\nFrati Cappuccini\ndell’Emilia-Romagna',
      'http://www.centromissionario.com/'
    ],
    [
      'CHIESA CATTOLICA',
      'DIOCESI di FAENZA-\nMODIGLIANA',
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
      'Diocesi di TRIVENTO\n(Chieti)',
      'http://www.diocesitrivento.it/'
    ],
    [
      'LE “BARBIANA” NEL\nMONDO DI OGGI',
      'Associazione AMAN\nIMAN NIGER',
      'http://www.brownsea.it/harambee/niger/'
    ],
    [
      'LE “BARBIANA” NEL\nMONDO DI OGGI',
      'Associazione D.U.MA\nonlus',
      'http://www.dumaonlus.it/'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'ARCICONFRATERNITA’\nDELLA MISERICORDIA\nDI FIRENZE',
      'http://www.misericordia.firenze.it/'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'Associazione NOI',
      'http://www.circolonoiferrovieri.it/'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'Giovani e Missione:\nPAULO FREIRE',
      'http://www.giovaniemissione.it/testimoni/paulofreire.htm'
    ],
    [
      'ORGANIZZAZIONI\nUMANITARIE',
      'Progetto AGATA\nSMERALDA per l’\nadozione a distanza',
      'http://www.agatasmeralda.org/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Istituto di Istruzione\nSuperiore SACRA\nFAMIGLIA di Soncino\n-CR-',
      'http://www.sacrafamigliasoncino.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Liceo “ALDO MORO”\ndi Reggio Emilia',
      'http://www.liceomoro.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Liceo BERCHET Milano',
      'http://www.liceoberchet.it/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Pontificia Facolta’\ndi Scienze dell’\nEducazione “AUXILIUM”',
      'http://www.pfse-auxilium.org/'
    ],
    [
      'SCUOLE ED\nUNIVERSITA’',
      'Scuola Secondaria di\n1^ grado “Don Lorenzo\nMilani” di TELVE in\nValsugana -TN',
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
      'FIM-CISL -Federazione\nItaliana Metalmeccanici\n– CISL',
      'http://www.fim.cisl.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di Firenze',
      'http://www.comune.firenze.it/'
    ],
    [
      'SOSTENITORI DELLA\nFONDAZIONE DON\nLORENZO MILANI',
      'Comune di Vicchio\ndel Mugello',
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
      'CENTRO DI\nORIENTAMENTO\nSIACIALE fondato\nda Aldo Capitini\nnel 1944',
      'http://www.cosinrete.it/'
    ],
    [
      'VARIE',
      'LA MARCIA DI\nBARBIANA',
      'http://www.marciadibarbiana.it/',
    ],
    [
      'VARIE',
      'Libreria HERDER –\nROMA',
      'http://www.herder.it/',
    ],
    [
      'VARIE',
      'URSEA; Unione\nrocciatori,scalatori\ne affini',
      'http://www.ursea.it/'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatti"),
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
              "\nSede Legale:\nLoc. Barbiana, 9 – 50031 Vicchio Mugello (FI)\n\nSede Operativa:\nVia Spinuci, 19 – 50141 Firenze\nTel. e Fax: 055.418811\n\nE-mail: contatti@donlorenzomilani.it",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 15,
                                    ),
                                    child: BorderedText(
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
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 25,
                                      left: 10,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        launch(info[2]);
                                      },
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
