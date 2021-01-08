import 'package:flutter/material.dart';

class InfoSeCHS extends StatelessWidget {
  static const String routeName = "/infosechs";
  @override
  Widget build(BuildContext context) {
    final List eventi = ModalRoute.of(context).settings.arguments as List;
    final String image = eventi[2];
    final List<String> evento = eventi[3];
    return Scaffold(
      appBar: AppBar(
        title: Text(eventi[0]),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              evento[0].toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              evento[1],
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            Text(
              evento[2].toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              evento[3],
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            Text(
              evento[4].toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              evento[5],
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            Image(
              image: AssetImage(image),
              fit: BoxFit.fitWidth,
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
