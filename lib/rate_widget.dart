import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  final String rate;
  final double height;
  final double width;

  RateWidget(this.rate, this.width, this.height);
  @override
  Widget build(BuildContext context) {
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
              size: height,
              color: Colors.yellow.shade800,
            )
          ],
        ),
      ),
    );
  }
}
