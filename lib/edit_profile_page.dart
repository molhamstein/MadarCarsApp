import 'package:flutter/material.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/edit_profile_widget.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/indicator_painter.dart';
import 'package:madar_booking/login_widget.dart';
import 'package:madar_booking/sign_up_widget.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => new _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;
  AuthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: MadarColors.gradiant_decoration,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text('Edit Profile'),
            ),
            backgroundColor: Colors.transparent,
            body: StreamBuilder<bool>(
              initialData: false,
              stream: bloc.lockTouchEventStream,
              builder: (context, snapshot) {
                print(snapshot.data);
                return _buildLayout(snapshot.data);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController();
    bloc = AuthBloc();
    super.initState();
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(
                    color: left,
                    fontSize: 16.0,
                    fontFamily: "WorkSansSemiBold",
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  _buildLayout(bool ignore) {
    return Stack(
      children: <Widget>[
        IgnorePointer(
          ignoring: ignore,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(flex: 2, child: EditProfileWidget()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
