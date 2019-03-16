import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/app_text_style.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/edit_profile_page.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/profile_bloc.dart';
import 'package:madar_booking/profile_header.dart';
import 'package:madar_booking/settings_page.dart';
import 'my_flutter_app_icons.dart';
import 'widgets/my_trip_card.dart';
import 'models/MyTrip.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc;
  static AppBloc appBloc;
  static final token = appBloc.token;
  List<MyTrip> trips = [];
  String imageUrl;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    imageUrl = appBloc.userImage;
    profileBloc = ProfileBloc(token);
    profileBloc.myTrips();
    profileBloc.getMe();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }

  Widget tripInfoCardList() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: profileBloc.myTrips,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: trips.length,
          itemBuilder: (BuildContext context, int index) {
            return MyTripCard(trips[index]);
          }),
    );
  }

  Widget myTrips() {
    return StreamBuilder<List<MyTrip>>(
      initialData: appBloc.myTrips,
      stream: profileBloc.myTripsStream,
      builder: (context, snapshot) {
        print(snapshot.data);
        // switch (snapshot.connectionState) {
        //   case ConnectionState.none:
        //     return Text("There is no connection");
        //   case ConnectionState.waiting:
        //     return Center(child: CircularProgressIndicator());
        //   default:
        if (snapshot.hasData) {
          this.trips = snapshot.data;
          appBloc.saveMyTrips(trips);
          return tripInfoCardList();
        } else if (snapshot.hasError) {
          if (appBloc.myTrips != null) {
            this.trips = appBloc.myTrips;
            return tripInfoCardList();
          } else {
            return ListTile(
              title: IconButton(
                onPressed: () {
                  profileBloc.myTrips();
                },
                icon: Icon(Icons.restore),
              ),
              subtitle: Text(
                  MadarLocalizations.of(context).trans('connection_error')),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
        // }
      },
    );
  }

  Widget profileImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(width: 5, color: Colors.white),
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: imageUrl != null
              ? NetworkImage(imageUrl)
              : AssetImage('assets/images/profileImg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  final double myHeight = 250.0;
  final double myWidth = 1000.0;
  final bool open = false;
  final Matrix4 rotateBy45 = new Matrix4.identity()
    ..rotateZ(-45 * 3.1415927 / 180)
    ..translate(-75.0, -50.0, 0.0)
    ..scale(1.0);
  final Matrix4 rotateBy0 = new Matrix4.identity()
    ..rotateZ(0 * 3.1415927 / 180)
    ..translate(0.0, 0.0, 0.0)
    ..scale(2.0);
  final Matrix4 transformation = new Matrix4.identity()
    ..rotateZ(-45 * 3.1415927 / 180)
    ..translate(-75.0, -50.0, 0.0)
    ..scale(1.0);
  final borderRaduice = BorderRadius.only(bottomRight: Radius.circular(100));

  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return BlocProvider(
      bloc: profileBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Stack(
          children: <Widget>[
            ProfileHeader(),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SafeArea(
                          child: Container(
                            height: 50,
                          ),
                        ),
                        StreamBuilder<User>(
                            stream: profileBloc.userStream,
                            initialData: appBloc.me,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.name != null) {
                                  appBloc.saveUser(snapshot.data);
                                  return Container(
                                    // color: Colors.blue,
                                    height: 122.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 25.0),
                                          child: profileImage(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            bloc.userName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return Container(
                                    height: 122.0,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                            }),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    constraints: BoxConstraints.expand(height: 30.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        MadarLocalizations.of(context).trans("Your_bookings"),
                        style: AppTextStyle.meduimTextStyleBlack,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 8.0, end: 0.0),
                      child: myTrips(),
                    ),
                  ),
                ],
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final imageUrlTemp = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()));
                      setState(() {
                        if (imageUrlTemp != null) {
                          imageUrl = imageUrlTemp;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        MyFlutterApp.edit_profile,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool s = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => MySettingsPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        MyFlutterApp.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
