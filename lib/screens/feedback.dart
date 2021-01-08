import 'package:flutter/material.dart';

import 'home/mainDrawer.dart';

class FeedBack extends StatelessWidget {
  static const String routeName = "/feedback";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      drawer: MainDrawer(),
    );
  }
}
