import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/profile_page.dart';
import 'package:madar_booking/rate_widget.dart';

class InvoicePage extends StatefulWidget {
  InvoicePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  AppBloc appBloc;

  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  var myHeight = 300.0;
  var myWidth = 300.0;
  var open = false;
  var rotateBy45 = new Matrix4.identity()
    ..rotateZ(-45 * 3.1415927 / 180)
    ..translate(-75.0, -50.0, 0.0)
    ..scale(1.0);
  var rotateBy_0 = new Matrix4.identity()
    ..rotateZ(0 * 3.1415927 / 180)
    ..translate(0.0, 0.0, 0.0)
    ..scale(2.0);
  var transformation = new Matrix4.identity()
    ..rotateZ(-45 * 3.1415927 / 180)
    ..translate(-75.0, -50.0, 0.0)
    ..scale(1.0);

  var border_raduice = BorderRadius.only(bottomRight: Radius.circular(100));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              decoration: BoxDecoration(
                  borderRadius: border_raduice,
                  gradient: MadarColors.gradiant_decoration),
              height: myHeight,
              width: myWidth,
              transform: transformation,
            ),
          ),
          Column(
            // homeScreen content
            children: <Widget>[],
          ),
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
