import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
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
      "url",
      "extract",
    ],
    [
      "title1",
      "date1",
      "url1",
      "extract1",
    ],
  ];

  final List<List> mediaVideo = [
    [
      "title2",
      "date2",
      "url2",
      "extract2",
    ],
    [
      "title3",
      "date3",
      "url3",
      "extract3",
    ],
  ];

  VideoPlayerController _controller;

  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(mediaVideo[0][0]);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
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
            CarouselSlider(
              items: mediaVideo
                  .map(
                    (infos) => new Container(
                      child: Row(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                ),
                                child: FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Center(
                                        child: AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
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
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Marquee(
                                child: Text(
                                  infos[0] + " - " + infos[1],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                animationDuration: Duration(seconds: 1),
                                backDuration: Duration(milliseconds: 5000),
                                pauseDuration: Duration(milliseconds: 2500),
                                directionMarguee: DirectionMarguee.oneDirection,
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
                viewportFraction: 0.8,
                onScrolled: (r) {
                  setState(() {
                    _controller = mediaVideo[index][2];
                    if (index == mediaVideo.length) {
                      index = 0;
                    } else {
                      index++;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CarouselSlider(
              items: mediaPhoto
                  .map(
                    (infos) => new Container(
                      child: Row(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                "",
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Marquee(
                                child: Text(
                                  infos[0] + " - " + infos[1],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                animationDuration: Duration(seconds: 1),
                                backDuration: Duration(milliseconds: 5000),
                                pauseDuration: Duration(milliseconds: 2500),
                                directionMarguee: DirectionMarguee.oneDirection,
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
            )
          ],
        ),
      ),
    );
  }
}
