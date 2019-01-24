import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';

class FinalStep extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Text(MadarLocalizations.of(context).trans('trip_created_successfully')),
      ),
    );
  }

}