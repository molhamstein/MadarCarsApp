import 'dart:ui';

import 'package:flutter/material.dart';

class SmilePainter extends CustomPainter {
  double slideValue = 200;

  ReviewState badReview;
  ReviewState okReview;
  ReviewState goodReview;

  double smileHeight;
  double halfWidth;
  double halfHeight;

  double radius;
  double diameter;
  double startingY;
  double startingX;

  double endingX;
  double endingY;

  double oneThirdOfDia;

  double oneThirdOfDiaByTwo;

  double eyeRadius;

  SmilePainter(double slideValue) : slideValue = slideValue;

  ReviewState currentState;

  @override
  void paint(Canvas canvas, Size size) {
    halfWidth = size.width / 2;
    halfHeight = size.width / 4;

    radius = halfHeight;
    eyeRadius = radius / 6;

    diameter = radius * 2;
    startingX = halfWidth - radius;
    startingY = halfHeight - radius;

    oneThirdOfDia = (diameter / 3);
    oneThirdOfDiaByTwo = oneThirdOfDia / 2;

    endingX = halfWidth + radius;
    endingY = halfHeight + radius;

    final leftSmileX = startingX + (radius / 2);

    badReview = ReviewState(
      Offset(leftSmileX, endingY - (oneThirdOfDiaByTwo * 1.3)),
      Offset(
          startingX + oneThirdOfDia, startingY + radius + (oneThirdOfDiaByTwo)),
      Offset(endingX - radius, startingY + radius + (oneThirdOfDiaByTwo)),
      Offset(
          endingX - oneThirdOfDia, startingY + radius + (oneThirdOfDiaByTwo)),
      Offset(endingX - (radius / 2), endingY - (oneThirdOfDiaByTwo * 1.3)),
    );

    okReview = ReviewState(
      Offset(leftSmileX, endingY - (oneThirdOfDiaByTwo * 1.5)),
      Offset(diameter, endingY - (oneThirdOfDiaByTwo * 1.5)),
      Offset(endingX - radius, endingY - (oneThirdOfDiaByTwo * 1.5)),
      Offset(startingX + radius, endingY - (oneThirdOfDiaByTwo * 1.5)),
      Offset(endingX - (radius / 2), endingY - (oneThirdOfDiaByTwo * 1.5)),
    );

    goodReview = ReviewState(
      Offset(startingX + (radius / 2), endingY - (oneThirdOfDiaByTwo * 2)),
      Offset(startingX + oneThirdOfDia,
          startingY + (diameter - oneThirdOfDiaByTwo)),
      Offset(endingX - radius, startingY + (diameter - oneThirdOfDiaByTwo)),
      Offset(
          endingX - oneThirdOfDia, startingY + (diameter - oneThirdOfDiaByTwo)),
      Offset(endingX - (radius / 2), endingY - (oneThirdOfDiaByTwo * 2)),
    );

    if (slideValue <= 100) {
      tween(badReview, okReview, slideValue / 100);
    } else if (slideValue <= 200) {
      tween(okReview, goodReview, (slideValue - 100) / 100);
    }

    final circlePaint = genGradientPaint(
      PaintingStyle.stroke,
    )..strokeCap = StrokeCap.round;

    canvas.drawPath(getSmilePath(currentState), circlePaint);

    final leftEyeX = startingX + oneThirdOfDia;
    final eyeY = startingY + (oneThirdOfDia + oneThirdOfDiaByTwo / 4);
    final rightEyeX = startingX + (oneThirdOfDia * 2);

    final leftEyePoint = Offset(leftEyeX, eyeY + halfWidth * 2);
    final rightEyePoint = Offset(rightEyeX, eyeY + halfWidth * 2);

    final Paint leftEyePaintFill = genGradientPaint(
      PaintingStyle.fill,
    );

    final Paint rightEyePaintFill = genGradientPaint(
      PaintingStyle.fill,
    );

    canvas.drawCircle(leftEyePoint, eyeRadius, leftEyePaintFill);
    canvas.drawCircle(rightEyePoint, eyeRadius, rightEyePaintFill);
  }

  tween(ReviewState oldExpression, ReviewState newExpression, double diff) {
    currentState = ReviewState.lerp(oldExpression, newExpression, diff);
  }

  Path getSmilePath(ReviewState state) {
    var smilePath = Path();
    smilePath.moveTo(state.leftOffset.dx, state.leftOffset.dy);
    smilePath.quadraticBezierTo(state.leftHandle.dx, state.leftHandle.dy,
        state.centerOffset.dx, state.centerOffset.dy);
    smilePath.quadraticBezierTo(state.rightHandle.dx, state.rightHandle.dy,
        state.rightOffset.dx, state.rightOffset.dy);
    return smilePath;
  }

  Paint genGradientPaint(PaintingStyle style) {
    return new Paint()
      ..strokeWidth = 16.0
      ..style = style
      ..color = Colors.grey[900];
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ReviewState {
  Offset leftOffset;
  Offset centerOffset;
  Offset rightOffset;

  Offset leftHandle;
  Offset rightHandle;

  ReviewState(
    this.leftOffset,
    this.leftHandle,
    this.centerOffset,
    this.rightHandle,
    this.rightOffset,
  );

  static ReviewState lerp(ReviewState start, ReviewState end, double ratio) {
    return ReviewState(
      Offset.lerp(start.leftOffset, end.leftOffset, ratio),
      Offset.lerp(start.leftHandle, end.leftHandle, ratio),
      Offset.lerp(start.centerOffset, end.centerOffset, ratio),
      Offset.lerp(start.rightHandle, end.rightHandle, ratio),
      Offset.lerp(start.rightOffset, end.rightOffset, ratio),
    );
  }
}
