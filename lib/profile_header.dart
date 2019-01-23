import 'package:flutter/material.dart';
import 'package:madar_booking/madar_colors.dart';

class ProfileHeader extends StatefulWidget {
  @override
  ProfileHeaderState createState() {
    return new ProfileHeaderState();
  }
}

class ProfileHeaderState extends State<ProfileHeader> {
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
    //   myHeight = MediaQuery.of(context).size.height;
    // myWidth = MediaQuery.of(context).size.width;
    // open = false;
    // Matrix4 rotateBy45 = new Matrix4.identity()
    //   ..rotateZ(-45 * 3.1415927 / 180)
    //   ..translate(-100.0, -100.0, 0.0)
    //   ..scale(1.0);
    // rotateBy_0 = new Matrix4.identity()
    //   ..rotateZ(0 * 3.1415927 / 180)
    //   ..translate(0.0, 0.0, 0.0)
    //   ..scale(1.0);
    // transformation = new Matrix4.identity()
    //   ..rotateZ(15.0 * 3.1415927 / 180)
    //   ..translate(-(myWidth * 0.3), -(myHeight), 0.0)
    //   ..scale(1.6);
    // borderRadius = BorderRadius.circular(100);

    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myWidth = MediaQuery.of(context).size.width;
    myHeight = 300.0;
    transformation = new Matrix4.identity()
      ..rotateZ(15.0 * 3.1415927 / 180)
      ..translate(-(myWidth * 0.3), -(myHeight + 25), 0.0)
      ..scale(1.6);
    borderRadius = BorderRadius.circular(100);

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
