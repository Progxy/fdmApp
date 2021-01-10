import 'package:fdmApp/screens/home/mainDrawer.dart';
import 'package:flutter/material.dart';

class DetailedPhoto extends StatelessWidget {
  static const String routeName = "/detailedphoto";
  @override
  Widget build(BuildContext context) {
    final List details = ModalRoute.of(context).settings.arguments as List;
    final titlePhoto = details[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(titlePhoto),
      ),
      drawer: MainDrawer(),
    );
  }
}
