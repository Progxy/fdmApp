import 'package:flutter/material.dart';

class DetailedPhoto extends StatelessWidget {
  static const String routeName = "/detailedphoto";
  @override
  Widget build(BuildContext context) {
    final List details = ModalRoute.of(context).settings.arguments as List;
    final titlePhoto = details[0];
    final textPhoto = details[3];
    return Scaffold(
      appBar: AppBar(
        title: Text(titlePhoto),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titlePhoto,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            textPhoto,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.network(
            details[2],
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
