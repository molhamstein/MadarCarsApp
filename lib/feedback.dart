import 'package:flutter/material.dart';

mixin UserFeedback {

  void showInSnackBar(String value, BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Scaffold.of(context)?.removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

}