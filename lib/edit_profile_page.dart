import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/edit_profile_widget.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/profile_bloc.dart';
import 'package:madar_booking/feedback.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => new _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin, UserFeedback {
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;
  AppBloc appBloc;
  AuthBloc bloc;
  ProfileBloc profileBloc;
  String token;
  String userId;
  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    _pageController = PageController();
    bloc = AuthBloc();
    userId = appBloc.userId;
    token = appBloc.token;
    profileBloc = ProfileBloc(token);
    profileBloc.getMe();
    super.initState();
  }

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
              title: Text(MadarLocalizations.of(context).trans("edit_profile")),
            ),
            backgroundColor: Colors.transparent,
            body: StreamBuilder<bool>(
              initialData: false,
              stream: bloc.lockTouchEventStream,
              builder: (context, snapshot) {
                print('isLocked ${snapshot.data}');
                return _buildLayout(snapshot.data);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildLayout(bool ignore) {
    return StreamBuilder<User>(
      stream: profileBloc.userStream,
      initialData: appBloc.me,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          appBloc.saveUser(snapshot.data);
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
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showInSnackBar(snapshot.error.toString(), context);
          });
          return Center(
            child: ListTile(
              title: IconButton(
                onPressed: () {
                  profileBloc.getMe();
                },
                icon: Icon(Icons.restore),
              ),
              subtitle: Text(
                  MadarLocalizations.of(context).trans('connection_error')),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
