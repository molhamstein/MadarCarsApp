import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateWidget extends StatelessWidget {
  final String rate;

  RateWidget(this.rate);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              rate,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Icon(
                FontAwesomeIcons.solidStar,
                size: 14,
                color: Colors.yellow.shade800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
