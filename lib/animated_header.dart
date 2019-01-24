import 'package:flutter/material.dart';
import 'package:madar_booking/madar_colors.dart';

class AnimatedHeader extends StatefulWidget {
  final bool isAnimate;

  AnimatedHeader({this.isAnimate});
  @override
  AnimatedHeaderState createState() {
    return new AnimatedHeaderState();
  }
}

class AnimatedHeaderState extends State<AnimatedHeader> {
  double myWidth;
  double myHeight;
  bool open;
  Matrix4 rotateBy_0;
  Matrix4 transformation;
  BorderRadius borderRadius;

  void handleTimeout() {
    // callback function
    print("time out");
    // containerWidgetHeight = 200;
    transformation = rotateBy_0;
    myHeight = MediaQuery.of(context).size.height;
    myWidth = MediaQuery.of(context).size.width;
    borderRadius = BorderRadius.circular(0);
    setState(() {});
  }

  @override
  void initState() {
    myHeight = 300.0;
    open = false;
    rotateBy_0 = new Matrix4.identity()
      ..rotateZ(0 * 3.1415927 / 180)
      ..translate(0.0, 0.0, 0.0)
      ..scale(1.0);
    transformation = new Matrix4.identity()
      ..translate(0.0, -(myHeight * 0.6), 0.0)
      ..rotateZ(25.0 * 3.1415927 / 180)
      ..scale(1.0);
    borderRadius = BorderRadius.circular(100);
    if (widget.isAnimate) {
      //   // Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        handleTimeout();
      });
      // });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myWidth = MediaQuery.of(context).size.width * 1.25;

    // TODO: implement build
    return Container(
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 700),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: MadarColors.gradiant_decoration,
        ),
        height: myHeight,
        width: myWidth,
        transform: transformation,
      ),
    );
  }
}
