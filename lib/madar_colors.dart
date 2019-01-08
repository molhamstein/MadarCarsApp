import 'dart:ui';

import 'package:flutter/material.dart';

class MadarColors {
  static const gradientUp = Color(0xFFedbacb);
  static const gradientDown = Color(0xFF9078f7);
  static const gradientBtnStart = Color(0xFF3f4547);
  static const gradientBtnEnd = Color(0xFF2d2e31);

  static const gradiant_decoration = LinearGradient(
      colors: [MadarColors.gradientUp, MadarColors.gradientDown],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);

  static const shadow = BoxShadow(
    color: Colors.grey,
    blurRadius: 10.0, // has the effect of softening the shadow
    spreadRadius: 5.0, // has the effect of extending the shadow
    offset: Offset(
      5.0, // horizontal, move right 10
      5.0, // vertical, move down 10
    ),
  );
}
