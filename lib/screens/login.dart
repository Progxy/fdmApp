import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Login"),
  //     ),
  //     drawer: MainDrawer(),
  //   );
  // }
  final String urlToStreamVideo =
      'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4';
  final VlcPlayerController controller = new VlcPlayerController(
      // Start playing as soon as the video is loaded.
      onInit: () {
    controller.play();
  });
  final int playerWidth = 640;
  final int playerHeight = 360;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: playerHeight,
            width: playerWidth,
            child: new VlcPlayer(
              aspectRatio: 16 / 9,
              url: urlToStreamVideo,
              controller: controller,
              placeholder: Center(child: CircularProgressIndicator()),
            )));
  }
}
