import 'package:flutter/material.dart';
import 'package:madar_booking/madar_colors.dart';

class LanguageTag extends StatelessWidget {

  final Text text;

  const LanguageTag({Key key, @required this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      decoration: BoxDecoration(
        color: MadarColors.gradientDown,
        borderRadius: BorderRadius.circular(15)
      ),
      child: text,
    );
  }

}