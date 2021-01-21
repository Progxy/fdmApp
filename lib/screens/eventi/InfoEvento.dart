import 'package:flutter/material.dart';

class InfoEvento extends StatelessWidget {
  static const String routeName = "/infoevento";
  @override
  Widget build(BuildContext context) {
    final List eventi = ModalRoute.of(context).settings.arguments as List;
    final String image = eventi[3].replaceAll('"', '');
    final String text = eventi[4];
    final String title = eventi[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Image.network(
              image,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Center(
                  child: Image(
                    image: AssetImage("assets/images/error_image.png"),
                  ),
                );
              },
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
