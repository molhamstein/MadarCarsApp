import 'package:flutter/material.dart';

import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/home_bloc.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/madar_fonts.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/profile_page.dart';
import 'package:madar_booking/car_card_widget.dart';
import 'package:madar_booking/trip_card_widget.dart';
import 'package:madar_booking/trip_planning/Trip_planing_page.dart';

class HomePage extends StatelessWidget {
  static const String route = 'home_page';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static AppBloc appBloc;
  static HomeBloc homeBloc;
  static final token = appBloc.token;
  List<Car> cars = [];
  List<TripModel> trips = [];
  AnimationController _controller;
  Animation<Offset> _carsOffsetFloat;
  Animation<Offset> _tripsOffsetFloat;
  Animation<Offset> _tripsButtonOffsetFloat;
  Animation<Offset> _navbarOffsetFloat;
  double myWidth;
  double myHeight;
  bool flag = true;
  bool open = false;
  Matrix4 rotateBy_0;
  Matrix4 transformation;
  BorderRadius borderRadius;

  void handelHeaderAnimation() {
    // callback function
    print("time out");
    // containerWidgetHeight = 200;
    transformation = rotateBy_0;
    myHeight = MediaQuery.of(context).size.height;
    myWidth = MediaQuery.of(context).size.width;
    borderRadius = BorderRadius.circular(0);
    setState(() {});
  }

  initHeaerAnimation() {
    myWidth = MediaQuery.of(context).size.width * 1.25;
    myHeight = myHeight = MediaQuery.of(context).size.height * 0.4;
    rotateBy_0 = new Matrix4.identity()
      ..translate(0.0, 0.0, 0.0)
      ..rotateZ(0 * 3.1415927 / 180)
      ..scale(1.0);
    transformation = new Matrix4.identity()
      ..translate(0.0, -(myHeight * 0.5), 0.0)
      ..rotateZ(25.0 * 3.1415927 / 180)
      ..scale(1.0);
    borderRadius = BorderRadius.circular(100);
    flag = false;
    open = false;
    setState(() {});
  }

  prepareAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.8));

    _carsOffsetFloat =
        Tween<Offset>(begin: Offset(600.0, 0.0), end: Offset.zero)
            .animate(curvedAnimation);
    _tripsOffsetFloat =
        Tween<Offset>(begin: Offset(-600.0, 0.0), end: Offset.zero)
            .animate(curvedAnimation);
    _tripsButtonOffsetFloat =
        Tween<Offset>(begin: Offset(0.0, 300.0), end: Offset.zero)
            .animate(curvedAnimation);
    _navbarOffsetFloat =
        Tween<Offset>(begin: Offset(0.0, -100.0), end: Offset.zero)
            .animate(curvedAnimation);
    _carsOffsetFloat.addListener(() {
      setState(() {});
    });

    _tripsOffsetFloat.addListener(() {
      setState(() {});
    });
    _tripsButtonOffsetFloat.addListener(() {
      setState(() {});
    });

    _navbarOffsetFloat.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    homeBloc = HomeBloc(token);
    homeBloc.predifindTrips();
    homeBloc.getCars();
    prepareAnimation();
    super.initState();
  }

  Widget _animatedHeader() {
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

  Widget _cardContainerList() {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height / 3.2),
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 5, top: 5),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: cars.length,
          itemBuilder: (BuildContext context, int index) {
            return CarCard(
              car: cars[index],
              onTap: (_) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TripPlanningPage()));
              },
            );
          }),
    );
  }

  Widget _availbleCars() {
    return AnimatedBuilder(
        animation: _carsOffsetFloat,
        builder: (context, widget) {
          return Transform.translate(
            offset: _carsOffsetFloat.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    MadarLocalizations.of(context).trans("Trending_Cars"),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              StreamBuilder<List<Car>>(
                initialData: [],
                stream: homeBloc.availableCarsStream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("There is no connection");
                    case ConnectionState.waiting:
                      return Container(
                          height: 225,
                          color: Colors.transparent,
                          child: Center(child: CircularProgressIndicator()));
                    default:
                      if (snapshot.hasError) {
                        return Text("Error}");
                      } else {
                        this.cars = snapshot.data;
                        return _cardContainerList();
                      }
                  }
                },
              ),
            ]),
          );
        });
  }

  Widget _tripCardContainerList() {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height / 3.8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TripPlanningPage(
                          tripModel: trips[index],
                        ),
                  ),
                );
              },
              child: TripCard(trips[index]),
            ),
          );
        },
      ),
    );
  }

  Widget predefiedTrips() {
    return AnimatedBuilder(
        animation: _tripsOffsetFloat,
        builder: (context, widget) {
          return Transform.translate(
            offset: _tripsOffsetFloat.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Text(
                      MadarLocalizations.of(context).trans('Recomended_Trips'),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                StreamBuilder<List<TripModel>>(
                  initialData: [],
                  stream: homeBloc.predefindTripsStream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("There is no connection");
                      case ConnectionState.waiting:
                        return Container(
                            height: 190,
                            child: Center(child: CircularProgressIndicator()));
                      default:
                        if (snapshot.hasError) {
                          return Text("Error: }");
                        } else {
                          this.trips = snapshot.data;
                          return _tripCardContainerList();
                        }
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(MadarLocalizations.of(context).locale.languageCode);
    if (flag || open) {
      _controller.forward().whenCompleteOrCancel(initHeaerAnimation);
    }
    return BlocProvider(
      bloc: homeBloc,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Hero(tag: "header_container", child: _animatedHeader()),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // homeScreen content
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  height: 60,
                ),
                predefiedTrips(),
                _availbleCars(),
                AnimatedBuilder(
                    animation: _tripsButtonOffsetFloat,
                    builder: (context, widget) {
                      return Transform.translate(
                          offset: _tripsButtonOffsetFloat.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment(0, 0),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            boxShadow: [MadarColors.shadow],
                                            color: Colors.grey.shade900,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              handelHeaderAnimation();
                                              _controller
                                                  .reverse()
                                                  .whenComplete(() {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100),
                                                    () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return TripPlanningPage();
                                                  }));
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    open = true;
                                                  });
                                                });
                                              });
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(8.0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          MadarLocalizations.of(context)
                                              .trans("Plan_a_Trip"),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ));
                    })
              ],
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Transform.translate(
                offset: _navbarOffsetFloat.value,
                child: AppBar(
                  centerTitle: true,
                  title: Text(
                    "${MadarLocalizations.of(context).trans("hello")} ${appBloc.userName}",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
