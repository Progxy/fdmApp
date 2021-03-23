import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapToWidget {
  final fontWeightList = {
    1: FontWeight.w300,
    2: FontWeight.normal,
    3: FontWeight.w600,
    4: FontWeight.bold,
    5: FontWeight.w800
  };

  selector(String type, Map content) {
    Widget contentEncoded;
    switch (type) {
      case "Link":
        contentEncoded = link(content);
        break;
      case "Image":
        contentEncoded = image(content);
        break;
      case "Text":
        contentEncoded = text(content);
        break;
      case "Padding":
        contentEncoded = padding(content);
        break;
    }
    return contentEncoded;
  }

  image(Map content) {
    final String link = content["ImageLink"];
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
      child: Image.network(
        link,
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
        height: 200,
        width: 200,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return Image.asset(
            "assets/images/error_image.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            width: 200,
            height: 200,
          );
        },
      ),
    );
    return result;
  }

  text(Map content) {
    final String text = content["Text"];
    final String top = content["Top"];
    final String bottom = content["Bottom"];
    final String right = content["Right"];
    final String left = content["Left"];
    final String size = content["Size"];
    final FontWeight fontWeight = fontWeightList[content["FontWeight"]];
    final Widget result = Padding(
      padding: EdgeInsets.only(
        top: double.parse(top),
        bottom: double.parse(bottom),
        left: double.parse(left),
        right: double.parse(right),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: double.parse(size),
          fontWeight: fontWeight,
        ),
      ),
    );
    return result;
  }

  link(Map content) {
    final String text = content["Text"];
    final String link = content["Link"];
    final String top = content["Top"];
    final String bottom = content["Bottom"];
    final String right = content["Right"];
    final String left = content["Left"];
    final String size = content["Size"];
    final FontWeight fontWeight = fontWeightList[content["FontWeight"]];
    final Widget result = Padding(
      padding: EdgeInsets.only(
        top: double.parse(top),
        bottom: double.parse(bottom),
        left: double.parse(left),
        right: double.parse(right),
      ),
      child: GestureDetector(
        onTap: () {
          launch(link);
        },
        child: Text(
          text == null ? link : text,
          style: TextStyle(
            fontSize: double.parse(size),
            fontWeight: fontWeight,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
    return result;
  }

  padding(Map content) {
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
      child: Container(),
    );
    return result;
  }
}
