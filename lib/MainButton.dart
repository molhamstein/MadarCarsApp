import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';

class MainButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  final bool loading;
  final double height;
  final double width;
  final Duration duration;
  final bool miniButton;
  final Function onMiniBtnPressed;

  const MainButton({
    Key key,
    this.onPressed,
    this.text,
    this.loading = false,
    this.height = 50,
    this.width = 150,
    this.duration,
    this.miniButton = false,
    this.onMiniBtnPressed,
  })  : assert(text != null),
        super(key: key);

  @override
  MainButtonState createState() {
    return new MainButtonState();
  }
}

class MainButtonState extends State<MainButton> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  Animation buttonSqueezeAnimation;
  double height;
  double width;

  @override
  void initState() {
    _loginButtonController = new AnimationController(
        duration: widget.duration ?? Duration(milliseconds: 300), vsync: this);
    buttonSqueezeAnimation = new Tween(
      begin: widget.width,
      end: widget.height,
    ).animate(new CurvedAnimation(
        parent: _loginButtonController, curve: new Interval(0.0, 0.250)));
    buttonSqueezeAnimation.addListener(() {
      setState(() {});
    });

    height = 0;
    width = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.miniButton) {
      height = 40;
      width = 100;
    } else {
      height = 0;
      width = 0;
    }
    return Container(
      margin: EdgeInsets.only(top: 220.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _miniButton(),
          Container(
            width: buttonSqueezeAnimation.value,
            height: widget.height,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20.0,
                  offset: Offset(0, 7),
                ),
              ],
              gradient: new LinearGradient(
                  colors: [
                    MadarColors.gradientBtnStart,
                    MadarColors.gradientBtnEnd
                  ],
                  begin: const FractionalOffset(0.2, 0.2),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: buttonSqueezeAnimation.value > widget.height
                ? MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.redAccent[100],
                    disabledColor: Colors.grey,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            height: 0.8),
                      ),
                    ),
                    onPressed: () {
                      widget.onPressed();
                      if (widget.loading) {
                        _loginButtonController.forward();
                      }
                    },
                  )
                : loading(),
          ),
        ],
      ),
    );
  }

  _miniButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onMiniBtnPressed,
        child: AnimatedContainer(
          curve: Curves.ease,
          margin: EdgeInsets.only(left: 16, right: 16),
          duration: Duration(milliseconds: 400),
          decoration: BoxDecoration(
            color: MadarColors.gradientDown,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: MadarColors.gradientUp,
              ),
            ],
          ),
          height: height,
          width: width,
          child: Center(
            child: width > 80
                ? Text(

              //Todo done
                    MadarLocalizations.of(context).trans('Book_Now'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  loading() {
    if (!widget.loading) {
      _loginButtonController.reverse();
    }
    return CircularProgressIndicator();
  }
}
