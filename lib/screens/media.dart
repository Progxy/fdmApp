import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/media/detailedPhoto.dart';
import 'package:fdmApp/screens/media/detailedVideo.dart';
import 'package:fdmApp/screens/utilizzo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'badConnection.dart';
import 'databaseManager.dart';
import 'feedback.dart';
import 'home/mainDrawer.dart';

class Media extends StatefulWidget {
  static const String routeName = "/media";
  Media({this.app});
  final FirebaseApp app;

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {
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

  List<YoutubePlayerController> _controllers = [];
  List<TextEditingController> _idControllers = [];
  List<TextEditingController> _seekToControllers = [];
  List<YoutubeMetaData> _videoMetaDatas = [];
  List<PlayerState> _playerStates = [];
  bool _isPlayerReady = false;
  final FirebaseDatabase database = FirebaseDatabase(app: Media().app);
  List dataVideo;
  List dataFoto;

  @override
  void initState() {
    super.initState();
    DatabaseManager().getMedia(database).then((arr) {
      dataVideo = arr[0];
      dataFoto = arr[1];
      int index = 0;
      for (var elements in dataVideo) {
        _controllers.add(YoutubePlayerController(
          initialVideoId: elements[2], //titolo, data, url, testo
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
            disableDragSeek: false,
            loop: true,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ),
        )..addListener(listener(index)));
        elements.add(index);
        index++;
        _idControllers.add(TextEditingController());
        _seekToControllers.add(TextEditingController());
        _videoMetaDatas.add(const YoutubeMetaData());
        _playerStates.add(PlayerState.unknown);
      }
    });
  }

  listener(int number) {
    if (_isPlayerReady && mounted && !_controllers[number].value.isFullScreen) {
      setState(() {
        _playerStates[number] = _controllers[number].value.playerState;
        _videoMetaDatas[number] = _controllers[number].metadata;
      });
    }
  }

  @override
  void deactivate() {
    for (var _controller in _controllers) {
      _controller.pause();
      super.deactivate();
    }
  }

  @override
  void dispose() {
    for (var _controller in _controllers) {
      _controller.dispose();
    }
    for (var _idController in _idControllers) {
      _idController.dispose();
      for (var _seekToController in _seekToControllers) {
        _seekToController.dispose();
        super.dispose();
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
          "Foto e Video",
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
        child: FutureBuilder(
          future: DatabaseManager().getContentHomePage(database),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  CarouselSlider(
                    items: dataVideo
                        .map(
                          (infos) => new Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 20,
                                      ),
                                      child: Center(
                                        child: YoutubePlayerBuilder(
                                          onExitFullScreen: () {
                                            SystemChrome
                                                .setPreferredOrientations(
                                                    DeviceOrientation.values);
                                          },
                                          player: YoutubePlayer(
                                            controller:
                                                _controllers[infos.last],
                                            showVideoProgressIndicator: true,
                                            progressIndicatorColor:
                                                Color.fromARGB(
                                                    255, 24, 37, 102),
                                            topActions: <Widget>[
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(
                                                  _controllers[infos.last]
                                                      .metadata
                                                      .title,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                            onReady: () {
                                              _isPlayerReady = true;
                                            },
                                          ),
                                          builder: (context, player) =>
                                              Container(
                                            child: player,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 110,
                                      ),
                                      child: SizedBox(
                                        height: 50,
                                        child: Marquee(
                                          text: infos[0] + " - " + infos[1],
                                          style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          blankSpace: 225,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          FloatingActionButton(
                                            heroTag: null,
                                            child: Icon(
                                              Icons.double_arrow,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Color.fromARGB(
                                                255, 24, 37, 102),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                DetailedVideo.routeName,
                                                arguments: infos,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: 300.0,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  CarouselSlider(
                    items: dataFoto
                        .map(
                          (infos) => new Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.network(
                                        infos[2].replaceAll('"', ''),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace stackTrace) {
                                          return Image(
                                            image: AssetImage(
                                                "assets/images/error_image.png"),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                      child: Marquee(
                                        text: infos[0] + " - " + infos[1],
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        blankSpace: 225,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 25,
                                            right: 10.0,
                                          ),
                                          child: FloatingActionButton(
                                            heroTag: null,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                DetailedPhoto.routeName,
                                                arguments: infos,
                                              );
                                            },
                                            child: Icon(
                                              Icons.double_arrow,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Color.fromARGB(
                                                255, 24, 37, 102),
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
                      height: 350.0,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
