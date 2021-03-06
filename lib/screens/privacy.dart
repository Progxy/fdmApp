import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:flutter/material.dart';

import 'badConnection.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';

class Privacy extends StatefulWidget {
  static const String routeName = "/privacy";

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  final List<String> choices = <String>[
    "FeedBack",
    "Aiuto",
  ];

  void choiceAction(String choice) async {
    if (choice == "Aiuto") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Utilizzo()));
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BadConnection()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedBack()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          "Privacy",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList();
            },
          )
        ],
        backgroundColor: Color.fromARGB(255, 24, 37, 102),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Privacy Policy\nQuesto sito web raccoglie alcuni dati personali dei propri utenti.\n\nTitolare del trattamento dei dati: Fondazione Don Lorenzo Milani Onlus\nVia Emidio Spinucci, 19 – 50141 Firenze (FI)\nIndirizzo email del titolare:  contatti@donlorenzomilani.it\n\nTipologie di dati raccolti\nFra i dati personali raccolti da questa applicazione, in modo autonomo o tramite terze parti, ci sono: Cookie e dati di utilizzo. Dettagli completi su ciascuna tipologia di dati raccolti sono forniti nelle sezioni dedicate di questa privacy policy o mediante specifici testi informativi visualizzati prima della raccolta dei dati stessi. I dati personali possono essere liberamente forniti dall’utente o, nel caso di dati di utilizzo, raccolti automaticamente durante l’uso di questa Applicazione. Tutti i dati richiesti da questa applicazione sono obbligatori e, in mancanza del loro conferimento, potrebbe essere impossibile per questa applicazione fornire il servizio. Nei casi in cui questa applicazione indichi alcuni dati come facoltativi, gli utenti sono liberi di astenersi dal comunicare tali dati, senza che ciò abbia alcuna conseguenza sulla disponibilità del servizio o sulla sua operatività.  Gli utenti che dovessero avere dubbi su quali dati siano obbligatori, sono incoraggiati a contattare il titolare. L’\neventuale utilizzo di cookie – o di altri strumenti di tracciamento – da parte di questa applicazione o dei titolari dei servizi terzi utilizzati da questa applicazione, ove non diversamente precisato, ha la finalità di fornire il servizio richiesto dall’utente, oltre alle ulteriori finalità descritte nel presente documento e nella cookie policy, se disponibile. L’utente si assume la responsabilità dei dati personali di terzi pubblicati o condivisi mediante questa applicazione e garantisce di avere il diritto di comunicarli o diffonderli, liberando il titolare da qualsiasi responsabilità verso terzi.\n\nModalità e luogo del trattamento dei Dati raccolti\nModalità di trattamento\nIl titolare tratta i dati personali degli utenti adottando le opportune misure di sicurezza volte ad impedire l’accesso, la divulgazione, la modifica o la distruzione non autorizzate dei dati personali. Il trattamento viene effettuato mediante strumenti informatici e/o telematici, con modalità organizzative e con logiche strettamente correlate alle finalità indicate. Oltre al titolare, in alcuni casi, potrebbero avere accesso ai dati categorie di incaricati coinvolti nell’organizzazione del sito (personale amministrativo, commerciale, marketing, legali, amministratori di sistema) ovvero soggetti esterni (come fornitori di servizi tecnici terzi, corrieri postali, hosting provider, società informatiche, agenzie di comunicazione) nominati anche, se necessario, responsabili del trattamento da parte del titolare. L’elenco aggiornato dei responsabili potrà sempre essere richiesto al titolare del trattamento.\n\nBase giuridica del trattamento\nIl Titolare tratta Dati Personali relativi all’Utente in caso sussista una delle seguenti condizioni:\n\nl’Utente ha prestato il consenso per una o più finalità specifiche; Nota: in alcuni ordinamenti il Titolare può essere autorizzato a trattare Dati Personali senza che debba sussistere il consenso dell’Utente o un’altra delle basi giuridiche specificate di seguito, fino a quando l’Utente non si opponga (“opt-out”) a tale trattamento. Ciò non è tuttavia applicabile qualora il trattamento di Dati Personali sia regolato dalla legislazione europea in materia di protezione dei Dati Personali;\nil trattamento è necessario all’esecuzione di un contratto con l’Utente e/o all’esecuzione di misure precontrattuali;\nil trattamento è necessario per adempiere un obbligo legale al quale è soggetto il Titolare;\nil trattamento è necessario per l’esecuzione di un compito di interesse pubblico o per l’esercizio di pubblici poteri di cui è investito il Titolare;\nil trattamento è necessario per il perseguimento del legittimo interesse del Titolare o di terzi.\nÈ comunque sempre possibile richiedere al Titolare di chiarire la concreta base giuridica di ciascun trattamento ed in particolare di specificare se il trattamento sia basato sulla legge, previsto da un contratto o necessario per concludere un contratto.\n\nLuogo\nI Dati sono trattati presso le sedi operative del Titolare ed in ogni altro luogo in cui le parti coinvolte nel trattamento siano localizzate. Per ulteriori informazioni, contatta il Titolare. I Dati Personali dell’Utente potrebbero essere trasferiti in un paese diverso da quello in cui l’Utente si trova. Per ottenere ulteriori informazioni sul luogo del trattamento l’Utente può fare riferimento alla sezione realtiva ai dettagli sul trattamento dei Dati Personali. L’Utente ha diritto a ottenere informazioni in merito alla base giuridica del trasferimento di Dati al di fuori dell’Unione Europea o ad un’organizzazione internazionale di diritto internazionale pubblico o costituita da due o più paesi, come ad esempio l’ONU, nonché in merito alle misure di sicurezza adottate dal Titolare per proteggere i Dati. Qualora abbia luogo uno dei trasferimenti appena descritti, l’Utente può fare riferimento alle rispettive sezioni di questo documento o chiedere informazioni al Titolare contattandolo agli estremi riportat\ni in apertura.\n\nPeriodo di conservazione\nI dati sono trattati e conservati per il tempo richiesto dalle finalità per le quali sono stati raccolti. Pertanto:\n\nI Dati Personali raccolti per scopi collegati all’esecuzione di un contratto tra il Titolare e l’Utente saranno trattenuti sino a quando sia completata l’esecuzione di tale contratto.\nI Dati Personali raccolti per finalità riconducibili all’interesse legittimo del Titolare saranno trattenuti sino al soddisfacimento di tale interesse. L’Utente può ottenere ulteriori informazioni in merito all’interesse legittimo perseguito dal Titolare nelle relative sezioni di questo documento o contattando il Titolare.\nQuando il trattamento è basato sul consenso dell’Utente, il Titolare può conservare i Dati Personali più a lungo sino a quando detto consenso non venga revocato. Inoltre il Titolare potrebbe essere obbligato a conservare i Dati Personali per un periodo più lungo in ottemperanza ad un obbligo di legge o per ordine di un’autorità. Al termine del periodo di conservazioni i Dati Personali saranno cancellati. Pertanto, allo spirare di tale termine il diritto di accesso, cancellazione, rettificazione ed il diritto alla portabilità dei Dati non potranno più essere esercitati.\n\n \n\nFinalità del Trattamento dei dati raccolti\nI dati dell’utente sono raccolti per consentire al Titolare di fornire i propri Servizi, così come per le seguenti finalità: Accesso agli account su servizi terzi, Interazione con social network e piattaforme esterne, Visualizzazione di contenuti da piattaforme esterne e Ottimizzazione e distribuzione del traffico. Per ottenere ulteriori informazioni dettagliate sulle finalità del trattamento e sui Dati Personali concretamente rilevanti per ciascuna finalità, l’Utente può fare riferimento alle relative sezioni di questo documento.\n\nPermessi Facebook richiesti da questo Sito Web\nQuesto Sito Web può richiedere alcuni permessi Facebook che le consentono di eseguire azioni con l’account Facebook dell’Utente e di raccogliere informazioni, inclusi Dati Personali, da esso. Questo servizio permette a questo Sito Web di connettersi con l’account dell’Utente sul social network Facebook, fornito da Facebook Inc. Per maggiori informazioni sui permessi che seguono, fai riferimento alla documentazione dei permessi Facebook ed alla privacy policy di Facebook. I permessi richiesti sono i seguenti:\n\nInformazioni di base\nLe informazioni di base dell’Utente registrato su Facebook che normalmente includono i seguenti Dati: id, nome, immagine, genere e lingua di localizzazione ed, in alcuni casi gli “Amici” di Facebook. Se l’Utente ha reso disponibili pubblicamente Dati ulteriori, gli stessi saranno disponibili.\n\nMi Piace\nFornisce accesso alla lista di tutte le pagine che l’Utente ha contrassegnato con il Mi Piace.",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
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
