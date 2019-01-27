import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';

class FinalStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                MadarLocalizations.of(context)
                    .trans('trip_created_successfully'),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/success_icon.png',
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
              child: Text(MadarLocalizations.of(context).trans('prices_may_vary'), style: TextStyle(
                color: Colors.grey[300], fontSize: 12,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
