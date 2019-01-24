import 'package:flutter/material.dart';
import 'package:madar_booking/animated_header.dart';
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
  List<Car> cars = [];
  List<TripModel> trips = [];
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  bool flag = false;

  Matrix4 carsTransformation;
  Matrix4 predefinedTripTransformation;

  hideContainers() {
    carsTransformation = new Matrix4.identity()..translate(0.0, -600.0, 0.0);
    predefinedTripTransformation = Matrix4.identity()
      ..translate(0.0, 600.0, 0.0);
  }

  showContainers() {
    carsTransformation = new Matrix4.identity()..translate(0.0, 0.0, 0.0);
    predefinedTripTransformation = Matrix4.identity()..translate(0.0, 0.0, 0.0);
  }

  static final token = appBloc.token;

  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    homeBloc = HomeBloc(token);
    homeBloc.predifindTrips();
    homeBloc.getCars();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 200.0), end: Offset.zero)
        .animate(curvedAnimation);

    _offsetFloat.addListener(() {
      setState(() {});
    });

    _controller.forward();

    super.initState();
  }

  Widget _cardContainerList() {
    return Container(
      constraints: BoxConstraints.expand(height: 225),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: cars.length,
          // itemExtent: 10.0,
          // reverse: true, //makes the list appear in descending order
          itemBuilder: (BuildContext context, int index) {
            return CarCard(car: cars[index]);
          }),
    );
  }

  Widget _availbleCars() {
    return AnimatedBuilder(
        animation: _offsetFloat,
        builder: (context, widget) {
          return Transform.translate(
            offset: _offsetFloat.value,
            child: Column(children: <Widget>[
              Container(
                color: Colors.transparent,
                constraints: BoxConstraints.expand(height: 50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cars",
                    style: TextStyle(
                        fontSize: AppFonts.large_font_size,
                        fontWeight: FontWeight.bold),
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
                        return Text("Error: ${snapshot.error}");
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
      // height: 190,
      constraints: BoxConstraints.expand(height: 190),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: trips.length,
        // itemExtent: 10.0,
        // reverse: true, //makes the list appear in descending order
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
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      transform: predefinedTripTransformation,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            constraints: BoxConstraints.expand(height: 50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recomended Trips",
                style: TextStyle(
                    fontSize: AppFonts.large_font_size,
                    fontWeight: FontWeight.bold),
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
                    return Text("Error: ${snapshot.error}");
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
  }

  @override
  Widget build(BuildContext context) {
    print(MadarLocalizations.of(context).locale.languageCode);
    return BlocProvider(
      bloc: homeBloc,
      child: Scaffold(
        body: Stack(children: <Widget>[
          AnimatedHeader(
            isAnimate: flag,
          ),
          SingleChildScrollView(
            child: Column(
              // homeScreen content
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  height: 125,
                ),
                predefiedTrips(),
                _availbleCars(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            // constraints: BoxConstraints.expand(width: 200),
                            alignment: Alignment(0, 0),
                            child: Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                  boxShadow: [MadarColors.shadow],
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment(0, 0),
                              child: FlatButton(
                                onPressed: () {
                                  // setState(() {
                                  //   flag = !flag;
                                  //   if (flag) {
                                  //     showContainers();
                                  //   } else {
                                  //     hideContainers();
                                  //   }
                                  // });
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return TripPlanningPage();
                                  }));
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(8.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Plan a Trip",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                title: Text(
                  "Hello ${appBloc.userName}",
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
                // textTheme: Theme.of(context)
                //     .textTheme
                //     .apply(displayColor: Colors.black, bodyColor: Colors.black),
              )),
        ]),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
