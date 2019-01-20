import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static AppBloc appBloc;
  List<Car> cars = [];
  List<TripModel> trips = [];

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

  // myWidth = MediaQuery.of(context).size.width;
  // myHeight = MediaQuery.of(context).size.height;
  // var third = myHeight / 3;
  // rotateBy45 = new Matrix4.identity()
  //   ..rotateZ(-45 * 3.1415927 / 180)
  //   ..translate(0, -150.0, 0.0);

  // rotateBy_0 = new Matrix4.identity()
  //   ..rotateZ(0 * 3.1415927 / 180)
  //   ..translate(0.0, 0.0, 0.0);

  // transformation = new Matrix4.identity()
  //   ..rotateZ(-45 * 3.1415927 / 180)
  //   ..translate(0, -(150.0), 0.0);

  var borderRadius = BorderRadius.circular(100);

  static final token = appBloc.token;
  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
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
    return Column(children: <Widget>[
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
      FutureBuilder<List<Car>>(
        future: Network().getAvailableCars(token),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("There is no connection");
            case ConnectionState.waiting:
              return Container(
                  height: 225,
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
      )
    ]);
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
          return TripCard(trips[index]);
        },
      ),
    );
  }

  Widget predefiedTrips() {
    return Column(
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
        FutureBuilder<List<TripModel>>(
          future: Network().getPredifinedTrips(appBloc.token),
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    myWidth = MediaQuery.of(context).size.width;
    myHeight = 300;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Hello ${appBloc.userName}",
      //     style: TextStyle(color: Colors.black, fontSize: 24),
      //   ),
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.person),
      //       onPressed: () {
      //         Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (context) => ProfilePage(),
      //           ),
      //         );
      //       },
      //       color: Colors.black,
      //     ),
      //   ],
      //   // textTheme: Theme.of(context)
      //   //     .textTheme
      //   //     .apply(displayColor: Colors.black, bodyColor: Colors.black),
      // ),
      body: Stack(children: <Widget>[
        Container(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: MadarColors.gradiant_decoration,
            ),
            height: myHeight,
            width: myWidth,
            transform: transformation,
          ),
        ),
        Column(
          // homeScreen content
          children: <Widget>[
            // Container(
            //   height: 50,
            // ),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 42.0),
            //           child: Align(
            //             alignment: Alignment.center,
            //             child: Text(
            //               "Hello ${appBloc.userName}",
            //               style: TextStyle(
            //                 fontSize: AppFonts.large_font_size,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       IconButton(
            //         icon: Icon(Icons.person),
            //         onPressed: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) => ProfilePage(),
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
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
                              print("clicked");
                              if (!open) {
                                transformation = rotateBy_0;
                                open = true;
                              } else {
                                transformation = rotateBy45;
                                open = false;
                              }
                              setState(() {});
                               Navigator.of(context)
                                   .push(MaterialPageRoute(builder: (context) {
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
    );
  }
}
