import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateWidget extends StatelessWidget {
  final String rate;

  RateWidget(this.rate);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
      child: Container(
        padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              rate,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                FontAwesomeIcons.solidStar,
                size: 16,
                color: Colors.yellow.shade800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
