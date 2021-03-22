import 'package:flutter/material.dart';

class MapToWidget {
  selector(String type, Map content) {
    Widget contentEncoded;
    switch (type) {
      case "Video":
        contentEncoded = video(content);
        break;
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

  video(Map content) {
    print("video received : $content");
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
    print("text received : $content");
  }

  link(Map content) {
    print("link received : $content");
  }

  padding(Map content) {
    print("padding received : $content");
  }
}
