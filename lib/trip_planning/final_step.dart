import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';

class FinalStep extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(MadarLocalizations.of(context).trans('trip_created_successfully')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/success_icon.png'),
          )
        ],
      ),
    );
  }

}