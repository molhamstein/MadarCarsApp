import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/madar_fonts.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/profile_page.dart';
import 'package:madar_booking/car_card_widget.dart';
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

  static double myHeight;
  static double myWidth;
  var open = false;
  static var rotateBy45;
  static var rotateBy_0;
  static var transformation;

  var borderRadius = BorderRadius.circular(200);

  static final token = appBloc.token;
  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);

    super.initState();
  }

  Widget _tripsCardContainer() {
    return InkWell(
      onTap: () {
        print("helllo");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [MadarColors.shadow],
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/images/bursa.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: 185,
          height: 185,
          child: Container(
            width: 185,
            height: 185,
            color: Color.fromARGB(180, 159, 108, 224),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Istanbol",
                          style: TextStyle(
                              fontSize: AppFonts.large_font_size,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: "3",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppFonts.x_large_font_size,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 30,
                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "Days",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                AppFonts.x_small_font_size,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        // width: 150,
                        child: Text(
                          "A 3 days trip to istanbol and the iseland of preincess ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppFonts.medium_font_size),
                          // softWrap: true,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardContainerList() {
    return Container(
      height: 225,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: cars.length,
          // itemExtent: 10.0,
          // reverse: true, //makes the list appear in descending order
          itemBuilder: (BuildContext context, int index) {
            return CarCard(cars[index]);
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
        Container(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 10,
            // itemExtent: 10.0,
            // reverse: true, //makes the list appear in descending order
            itemBuilder: (BuildContext context, int index) {
              return _tripsCardContainer();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // myWidth = MediaQuery.of(context).size.width;
    // myHeight = MediaQuery.of(context).size.height;
    // // var third = myHeight / 3;
    // rotateBy45 = new Matrix4.identity()
    //   ..rotateZ(-45 * 3.1415927 / 180)
    //   ..translate(0, -150.0, 0.0);

    // rotateBy_0 = new Matrix4.identity()
    //   ..rotateZ(0 * 3.1415927 / 180)
    //   ..translate(0.0, 0.0, 0.0);

    // transformation = new Matrix4.identity()
    //   ..rotateZ(-45 * 3.1415927 / 180)
    //   ..translate(0, -(150.0), 0.0);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Hello Nour!",
      //     style: TextStyle(color: Colors.black, fontSize: 24),
      //   ),
      //   elevation: 0.0,
      //   backgroundColor: Color.fromARGB(0, 255, 255, 255),
      //   // textTheme: Theme.of(context)
      //   //     .textTheme
      //   //     .apply(displayColor: Colors.black, bodyColor: Colors.black),
      // ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
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
              Container(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 42.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Hello ${appBloc.userName}",
                            style: TextStyle(
                              fontSize: AppFonts.large_font_size,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
              ),
              _tripCardContainerList(),
              _availbleCars(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
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
                            // print("pressed");
                            // if (!open) {
                            //   transformation = rotateBy_0;
                            //   borderRadius = BorderRadius.circular(0);
                            //   open = true;
                            // } else {
                            //   open = false;
                            //   transformation = rotateBy45;
                            //   borderRadius = BorderRadius.circular(200);
                            // }
                            // setState(() {});
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
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
