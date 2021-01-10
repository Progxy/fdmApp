import 'package:carousel_slider/carousel_slider.dart';
import 'package:fdmApp/screens/media/detailedPhoto.dart';
import 'package:fdmApp/screens/media/detailedVideo.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:video_player/video_player.dart';

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
      "extract",
    ],
    [
      "title1",
      "date1",
      "https://www.donlorenzomilani.it/wp-content/uploads/2017/06/papabarbiana7853-800x445.jpg",
      "extract1",
    ],
  ];

  final List<List> mediaVideo = [
    [
      "title2",
      "date2",
      "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
      "extract2",
    ],
    [
      "title3",
      "date3",
      "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
      "extract3",
    ],
  ];

  VideoPlayerController _controller;

  Future<void> _initializeVideoPlayerFuture;

  String titleVideo = "";
  String dateVideo = "";

  @override
  void initState() {
    _controller = VideoPlayerController.network(mediaVideo[0][2]);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleVideo = mediaVideo[index][0];
    dateVideo = mediaVideo[index][1];
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Center(
                                  child: AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.blueGrey,
                                    strokeWidth: 5.0,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 250.0,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                onScrolled: (r) {
                  setState(() {
                    _controller =
                        VideoPlayerController.network(mediaVideo[index][2]);
                    _initializeVideoPlayerFuture = _controller.initialize();
                    _controller.setLooping(true);
                    _controller.setVolume(1.0);
                    titleVideo = mediaVideo[index][0];
                    dateVideo = mediaVideo[index][0];
                    print("\n\n$titleVideo - $dateVideo\n\n");
                    if (index > mediaVideo.length - 1) {
                      index++;
                    } else {
                      index = 0;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: null,
                    elevation: 20.0,
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: FloatingActionButton(
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: Marquee(
                text: titleVideo + " - " + dateVideo,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
                blankSpace: 225,
              ),
            ),
            SizedBox(
              height: 25,
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
                          Image.network(
                            infos[2],
                            loadingBuilder: (ctx, i, k) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 5.0,
                              ),
                            ),
                            errorBuilder: (ctx, o, n) {
                              print("Object: $o\n\nStackTrace: $n\n\n");
                              return Center(
                                child: Icon(
                                  Icons.error,
                                  size: 50,
                                ),
                              );
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
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
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: FloatingActionButton(
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
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
