import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  List resultInfos = [];
  List resultDisponibilita = [];
  List resultMedia = [];
  List resultSeCHS = [];
  contentHomePage(FirebaseDatabase database) async {
    await database
        .reference()
        .child("News")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      final String verifyEvent = "Evento";
      List eventi = [];
      List info = [];
      List infoData = [];
      List eventoData = [];
      List general = [];
      List generalEventi = [];
      List generalInfo = [];
      map.forEach((name, valueList) =>
          name.startsWith(verifyEvent) ? eventi.add(name) : info.add(name));
      map.forEach((name, valueList) => name.startsWith(verifyEvent)
          ? valueList.forEach(
              (k, val) => (val.forEach((key, v) => (eventoData.add(v)))))
          : valueList.forEach(
              (k, val) => (val.forEach((key, v) => (infoData.add(v))))));
      int r = 0;
      int index = 0;
      for (var i in eventi) {
        List tempor = [];
        tempor.add(i);
        tempor.add(eventoData[r]);
        tempor.add(eventoData[r + 1]);
        tempor.add(eventoData[r + 2]);
        tempor.add(eventoData[r + 3]);
        generalEventi.add(tempor);
        r += 4;
      }
      for (var i in info) {
        List tempor = [];
        tempor.add(i);
        tempor.add(infoData[index]);
        tempor.add(infoData[index + 1]);
        tempor.add(infoData[index + 2]);
        tempor.add(infoData[index + 3]);
        generalInfo.add(tempor);
        index += 4;
      }
      general.add(generalEventi);
      general.add(generalInfo);
      resultInfos = general;
    });
  }

  getContentHomePage(FirebaseDatabase database) async {
    await contentHomePage(database);
    return resultInfos;
  }

  contentDisponibilita(FirebaseDatabase database) async {
    await database
        .reference()
        .child("Disponibilita")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      List generalDate = [];
      List generalVolontari = [];
      List general = [];
      map.forEach((name, valueList) => generalDate.add(name));
      map.forEach((name, valueList) => valueList.forEach((k, val) =>
          (val.forEach((key, value) => (generalVolontari.add(value))))));
      int index = 0;
      for (var i in generalDate) {
        List tempor = [];
        tempor.add(i);
        tempor.add(generalVolontari[index]);
        general.add(tempor);
        index += 1;
      }
      resultDisponibilita = general;
    });
  }

  getDisponibilita(FirebaseDatabase database) async {
    await contentDisponibilita(database);
    return resultDisponibilita;
  }

  contentMedia(FirebaseDatabase database) async {
    await database
        .reference()
        .child("Media")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      final String video = "Video";
      List videoTitle = [];
      List videoData = [];
      List fotoTitle = [];
      List fotoData = [];
      List generalVideo = [];
      List generalFoto = [];
      List general = [];
      map.forEach((name, valueList) =>
          name.startsWith(video) ? videoTitle.add(name) : fotoTitle.add(name));
      map.forEach((name, valueList) => name.startsWith(video)
          ? valueList.forEach(
              (k, val) => (val.forEach((key, value) => (videoData.add(value)))))
          : valueList.forEach((k, val) =>
              (val.forEach((key, value) => (fotoData.add(value))))));
      int index = 0;
      for (var i in videoTitle) {
        List tempor = [];
        tempor.add(i);
        tempor.add(videoData[index]);
        tempor.add(videoData[index + 1]);
        tempor.add(videoData[index + 2]);
        generalVideo.add(tempor);
        index += 3;
      }
      index = 0;
      for (var i in fotoTitle) {
        List tempor = [];
        tempor.add(i);
        tempor.add(fotoData[index]);
        tempor.add(fotoData[index + 1]);
        tempor.add(fotoData[index + 2]);
        generalFoto.add(tempor);
        index += 3;
      }
      general.add(generalVideo);
      general.add(generalFoto);
      resultMedia = general;
    });
  }

  getMedia(FirebaseDatabase database) async {
    await contentMedia(database);
    return resultMedia;
  }

  contentSeCHS(FirebaseDatabase database) async {
    await database
        .reference()
        .child("SeCHS")
        .orderByValue()
        .once()
        .then((DataSnapshot snapshot) {
      Map map = new Map.from(snapshot.value);
      final String stampa = "Stampa";
      List stampaTitle = [];
      List stampaData = [];
      List chsTitle = [];
      List chsData = [];
      List generalStampa = [];
      List generalCHS = [];
      List general = [];
      map.forEach((name, valueList) =>
          name.startsWith(stampa) ? stampaTitle.add(name) : chsTitle.add(name));
      map.forEach((name, valueList) => name.startsWith(stampa)
          ? valueList.forEach((k, val) =>
              (val.forEach((key, value) => (stampaData.add(value)))))
          : valueList.forEach(
              (k, val) => (val.forEach((key, value) => (chsData.add(value))))));
      int index = 0;
      for (var i in stampaTitle) {
        List tempor = [];
        tempor.add(i);
        tempor.add(stampaData[index]);
        tempor.add(stampaData[index + 1]);
        tempor.add(stampaData[index + 2]);
        generalStampa.add(tempor);
        index += 3;
      }
      index = 0;
      for (var i in chsTitle) {
        List tempor = [];
        tempor.add(i);
        tempor.add(chsData[index]);
        tempor.add(chsData[index + 1]);
        tempor.add(chsData[index + 2]);
        generalCHS.add(tempor);
        index += 3;
      }
      general.add(generalStampa);
      general.add(generalCHS);
      resultSeCHS = general;
    });
  }

  getSeCHS(FirebaseDatabase database) async {
    await contentMedia(database);
    return resultSeCHS;
  }
}
