import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingValue extends StatefulWidget {
  final Function(int) onTap;
  final int value;
  final bool selected;

  const RatingValue({Key key, this.onTap, this.value, this.selected})
      : super(key: key);

  @override
  RatingValueState createState() {
    return new RatingValueState();
  }
}

class RatingValueState extends State<RatingValue>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacity;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected)
      controller.forward();
    else
      controller.reverse();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => widget.onTap(widget.value),
          splashColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.value.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: opacity,
          child: Icon(
            FontAwesomeIcons.solidCircle,
            color: Colors.white,
            size: 12,
          ),
        )
      ],
    );
  }
}
