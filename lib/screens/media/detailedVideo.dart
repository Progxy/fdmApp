import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/material.dart';

class DetailedVideo extends StatelessWidget {
  static const String routeName = "/detailedvideo";
  @override
  Widget build(BuildContext context) {
    final List details = ModalRoute.of(context).settings.arguments as List;
    final videoTitle = details[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(videoTitle),
      ),
      drawer: MainDrawer(),
    );
  }
}
