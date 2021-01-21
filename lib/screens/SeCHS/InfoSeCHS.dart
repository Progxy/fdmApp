import 'package:flutter/material.dart';

class InfoSeCHS extends StatelessWidget {
  static const String routeName = "/infosechs";
  @override
  Widget build(BuildContext context) {
    final List eventi = ModalRoute.of(context).settings.arguments as List;
    final String image = eventi[3];
    final String testo = eventi[2];
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
            SizedBox(
              height: 15,
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              testo,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Image.network(
              image.replaceAll('"', ''),
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
