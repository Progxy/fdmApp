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
  static bool isLoaded = false;

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

  refresh() {
    setState(() {
      print("refresh");
    });
  }

  video(Map content) async {
    final String top = content["Top"];
    final String bottom = content["Bottom"];
    final String right = content["Right"];
    final String left = content["Left"];
    final String videoLink = content["VideoLink"];
    isSecondary = _videoController != null;
    if (isSecondary) {
      _videoControllerSecondary = VideoPlayerController.network(videoLink);
      await _videoControllerSecondary.initialize();
      await _videoControllerSecondary.setLooping(true);
    } else {
      _videoController = VideoPlayerController.network(videoLink);
      await _videoController.initialize();
      await _videoController.setLooping(true);
    }
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
    refresh();
  }

  managerVideocontrollerSecondary() {
    setState(() {
      _videoControllerSecondary.value.isPlaying
          ? _videoControllerSecondary.pause()
          : _videoControllerSecondary.play();
    });
    refresh();
  }

  loadContent(Map infoContent) async {
    if (InfoEvento.isLoaded) {
      return;
    } else {
      InfoEvento.isLoaded = true;
    }
    final contentInfo = MapDecoder().decoder(infoContent["Content"]);
    List<Widget> result = [];
    for (var element in contentInfo) {
      var type = element["Type"];
      if (type == "Video") {
        result.add(await video(element));
      } else {
        result.add(MapToWidget().selector(type, element));
      }
    }
    setState(() {
      contents = result;
    });
    return;
  }

  VideoPlayerController _videoController;
  VideoPlayerController _videoControllerSecondary;
  List<Widget> contents = [
    Center(
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
      ),
    ),
  ];

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
    loadContent(infoContent);

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
              children: contents,
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
