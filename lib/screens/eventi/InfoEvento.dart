import 'package:connectivity/connectivity.dart';
import 'package:fdmApp/screens/mapToWidget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../badConnection.dart';
import '../feedback.dart';
import '../mapDecoder.dart';
import '../utilizzo.dart';

class InfoEvento extends StatefulWidget {
  static const String routeName = "/infoevento";

  @override
  _InfoEventoState createState() => _InfoEventoState();
}

class _InfoEventoState extends State<InfoEvento> {
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

  bool isSecondary = false;
  int numVideoPlayer = 0;

  video(Map content) {
    numVideoPlayer += 1;
    if (numVideoPlayer == 2) {
      isSecondary = true;
    }
    final String top = content["Top"];
    final String bottom = content["Bottom"];
    final String right = content["Right"];
    final String left = content["Left"];
    final Widget result = Padding(
      padding: EdgeInsets.only(
        top: double.parse(top),
        bottom: double.parse(bottom),
        left: double.parse(left),
        right: double.parse(right),
      ),
      child: GestureDetector(
        onTap: isSecondary
            ? () => managerVideocontrollerSecondary()
            : () => managerVideoController(),
        child: Container(
          child: isSecondary
              ? _videoControllerSecondary.value.initialized
                  ? AspectRatio(
                      aspectRatio: _videoControllerSecondary.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          VideoPlayer(_videoControllerSecondary),
                          VideoProgressIndicator(
                            _videoControllerSecondary,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor:
                                  const Color.fromARGB(255, 24, 37, 102),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.black,
                      height: 200,
                      width: 200,
                    )
              : _videoController.value.initialized
                  ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          VideoPlayer(_videoController),
                          VideoProgressIndicator(
                            _videoController,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor:
                                  const Color.fromARGB(255, 24, 37, 102),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.black,
                      height: 200,
                      width: 200,
                    ),
        ),
      ),
    );
    return result;
  }

  managerVideoController() {
    setState(() {
      _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play();
    });
  }

  managerVideocontrollerSecondary() {
    setState(() {
      _videoControllerSecondary.value.isPlaying
          ? _videoControllerSecondary.pause()
          : _videoControllerSecondary.play();
    });
  }

  VideoPlayerController _videoController;
  VideoPlayerController _videoControllerSecondary;

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _videoControllerSecondary.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map infoContent = ModalRoute.of(context).settings.arguments as Map;
    final String title = infoContent["Title"];
    final contentInfo = MapDecoder().decoder(infoContent["Content"]);
    List<Widget> result = [];
    for (var element in contentInfo) {
      var type = element["Type"];
      if (type == "Video") {
        result.add(video(element));
      } else {
        result.add(MapToWidget().selector(type, element));
      }
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        title: Text(
          title,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Column(
              children: result,
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
