import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  String rate = "";
  double height = 20;
  double width = 50;
  RateWidget({this.rate, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              rate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.star,
              size: 20,
              color: Colors.yellow.shade800,
            )
          ],
        ),
      ),
    );
  }
}
