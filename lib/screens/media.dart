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
  int index = 0;
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
    ],
    [
      "title3",
      "date3",
      "OCLl6dGK11Q",
      "infos_arcticle3",
    ],
  ];

  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: mediaVideo[0][2],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
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
                                      controller: _controller,
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.blueGrey,
                                      topActions: <Widget>[
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            _controller.metadata.title,
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
                                          arguments: mediaVideo[index],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: <Widget>[
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: <Widget>[
                          //           FloatingActionButton(
                          //             heroTag: null,
                          //             child: Icon(
                          //               _controller.value.isPlaying
                          //                   ? Icons.pause
                          //                   : Icons.play_arrow,
                          //               size: 30,
                          //             ),
                          //             backgroundColor: Colors.blueGrey,
                          //             onPressed: _isPlayerReady
                          //                 ? () {
                          //                     _controller.value.isPlaying
                          //                         ? _controller.pause()
                          //                         : _controller.play();
                          //                     setState(() {});
                          //                   }
                          //                 : null,
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                  onPageChanged: (r, m) {
                    setState(() {
                      index = r;
                    });
                    _controller.load(mediaVideo[index][2]);
                    _controller.pause();
                  }),
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
                                          arguments: mediaPhoto[index],
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
