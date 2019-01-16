import 'package:flutter/material.dart';

class MadarVerticalDivider extends StatelessWidget {

  final double height;
  final Color color;

  const MadarVerticalDivider({Key key, this.height = 30, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 2,
      color: color,
    );
  }

}