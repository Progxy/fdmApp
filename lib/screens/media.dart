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
      "https://www.donlorenzomilani.it/fotografie-scuola-tavernerio-co-intitolata-don-lorenzo-milani/",
      "extract",
    ],
    [
      "title1",
      "date1",
      "https://www.donlorenzomilani.it/20-giugno-2017-barbiana-2/",
      "extract1",
    ],
  ];

  final List<List> mediaVideo = [
    [
      "title2",
      "date2",
      "https://youtu.be/OPm1TJXjXyk",
      "extract2",
    ],
    [
      "title3",
      "date3",
      "https://youtu.be/OPm1TJXjXyk",
      "extract3",
    ],
  ];

  VideoPlayerController _controller;

  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(mediaVideo[0][2]);
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
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
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
                      child: Icon(
                        Icons.double_arrow,
                        size: 30,
                      ),
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Marquee(
              child: Text(
                mediaVideo[index][0] + " - " + mediaVideo[index][1],
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
                            loadingBuilder: (ctx, i, k) => Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 150,
                                child:
                                    Center(child: CircularProgressIndicator())),
                            errorBuilder: (ctx, o, n) {
                              print(o);
                              return Center(
                                child: Icon(
                                  Icons.error,
                                  size: 40,
                                ),
                              );
                            },
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
                  height: 250.0,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
