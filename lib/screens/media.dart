import 'package:carousel_slider/carousel_slider.dart';
import 'package:fdmApp/screens/media/detailedPhoto.dart';
import 'package:fdmApp/screens/media/detailedVideo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'home/mainDrawer.dart';

class Media extends StatefulWidget {
  static const String routeName = "/media";

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {
  final List<List> mediaPhoto = [
    [
      "title",
      "date",
      "https://www.donlorenzomilani.it/wp-content/uploads/2017/03/23-marzo-relatori-800x445.jpg",
      "infos_arcticle",
    ],
    [
      "title1",
      "date1",
      "https://www.donlorenzomilani.it/wp-content/uploads/2017/06/papabarbiana7853-800x445.jpg",
      "infos_arcticle1",
    ],
  ];

  final List<List> mediaVideo = [
    [
      "title2",
      "date2",
      "fzoF_KhJO8c",
      "infos_arcticle2",
      0,
    ],
    [
      "title3",
      "date3",
      "OCLl6dGK11Q",
      "infos_arcticle3",
      1,
    ],
  ];

  List<YoutubePlayerController> _controllers = [];
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    int index = 0;
    for (var element in mediaVideo) {
      _controllers.add(YoutubePlayerController(
        initialVideoId: element[2],
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
      index++;
      print(index);
    }
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  listener(int number) {
    if (_isPlayerReady && mounted && !_controllers[number].value.isFullScreen) {
      setState(() {
        _playerState = _controllers[number].value.playerState;
        _videoMetaData = _controllers[number].metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    for (var _controller in _controllers) {
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    for (var _controller in _controllers) {
      _controller.dispose();
      _idController.dispose();
      _seekToController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto e Video"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            CarouselSlider(
              items: mediaVideo
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
                                      SystemChrome.setPreferredOrientations(
                                          DeviceOrientation.values);
                                    },
                                    player: YoutubePlayer(
                                      controller: _controllers[infos.last],
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.blueGrey,
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
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                      onReady: () {
                                        _isPlayerReady = true;
                                      },
                                    ),
                                    builder: (context, player) => Container(
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
                                  top: 115,
                                ),
                                child: SizedBox(
                                  height: 30,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FloatingActionButton(
                                      heroTag: null,
                                      child: Icon(
                                        Icons.double_arrow,
                                        size: 30,
                                      ),
                                      backgroundColor: Colors.blueGrey,
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FloatingActionButton(
                                      heroTag: null,
                                      child: Icon(
                                        _controllers[infos.last].value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 30,
                                      ),
                                      backgroundColor: Colors.blueGrey,
                                      onPressed: _isPlayerReady
                                          ? () {
                                              _controllers[infos.last]
                                                      .value
                                                      .isPlaying
                                                  ? _controllers[infos.last]
                                                      .pause()
                                                  : _controllers[infos.last]
                                                      .play();
                                              setState(() {});
                                            }
                                          : null,
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
              items: mediaPhoto
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
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.network(
                                  infos[2],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 115,
                                ),
                                child: SizedBox(
                                  height: 30,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                      ),
                                      backgroundColor: Colors.blueGrey,
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
                height: 275.0,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
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
