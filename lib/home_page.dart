import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/profile_page.dart';
import 'package:madar_booking/rate_widget.dart';

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
  AppBloc appBloc;

  int _counter = 0; // DataStore().counter;
  static const double _x_small_font_size = 8;
  static const double _small_font_size = 14;
  static const double _medium_font_size = 17;
  static const double _large_font_size = 24;
  static const double _x_large_font_size = 50;

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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 2.0, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage('assets/images/bursa.jpg'),
                  fit: BoxFit.cover)
              // image: DecorationImage(
              //   image: ExactAssetImage(''),
              //   fit: BoxFit.cover,
              // ),
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
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                              fontSize: _large_font_size,
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
                                        fontSize: _x_large_font_size,
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
                                            fontSize: _x_small_font_size,
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
                              color: Colors.white, fontSize: _medium_font_size),
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

  //card Container
  Widget _cardContainer() {
    return InkWell(
      onTap: () {
        print("helllo");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300,
          // height: 225.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 2.0, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  // image container
                  // height: 175.0,
                  child: Container(
                    decoration: containerDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 24.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: () {
                            print("helllp");
                          },
                          textColor: Colors.white,
                          child: Text(
                            "Busra",
                            style: TextStyle(
                              fontSize: _small_font_size,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color.fromARGB(255, 36, 36, 36),
                        ),
                      ),
                    ),
                    alignment: Alignment(-1.0, 1.0),
                  ),
                ),
              ),
              // info container
              Expanded(
                flex: 1,
                child: Container(
                  // height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Ford Mustang",
                                  style: TextStyle(
                                      fontSize: _small_font_size,
                                      fontWeight: FontWeight.bold,
                                      height: 1.25),
                                ),
                                Text("2013",
                                    style: TextStyle(
                                        fontSize: _small_font_size,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RateWidget(rate: "4.5",width: 50,height: 20,),
                                Text("Mahmot Orhan",
                                    style: TextStyle(
                                        fontSize: _small_font_size,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: '110',
                                        style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontSize: _large_font_size,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '\$',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("/day",
                                    style: TextStyle(
                                        fontSize: _small_font_size,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade600))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardContainerList() {
    return Column(children: <Widget>[
      Container(
        color: Colors.transparent,
        constraints: BoxConstraints.expand(height: 50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Cars",
            style: TextStyle(
                fontSize: _large_font_size, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      Container(
        height: 225,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 10,
            // itemExtent: 10.0,
            // reverse: true, //makes the list appear in descending order
            itemBuilder: (BuildContext context, int index) {
              return _cardContainer();
            }),
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
                  fontSize: _large_font_size, fontWeight: FontWeight.bold),
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
              }),
        ),
      ],
    );
  }

  final containerDecoration = new BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 20.0, // has the effect of softening the shadow
          spreadRadius: 5.0, // has the effect of extending the shadow
          offset: Offset(
            10.0, // horizontal, move right 10
            10.0, // vertical, move down 10
          ),
        )
      ],
      
      // image: DecorationImage(
      //   image: ExactAssetImage('images/image.jpg'),
      //   fit: BoxFit.fill,
      // ),
      image: DecorationImage(
          image: AssetImage('assets/images/ford.jpg'), fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(5.0));

  void _incrementCounter() async {
    setState(() {
      _counter++;
      //  DataStore().setCounter(_counter);
      print('$_counter');
    });
  }

  final gradientDecoration = LinearGradient(
      colors: [MadarColors.gradientUp, MadarColors.gradientDown],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);

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

  var borderRadius = BorderRadius.circular(100);

  @override
  Widget build(BuildContext context) {
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
                  gradient: LinearGradient(
                      colors: [
                        MadarColors.gradientUp,
                        MadarColors.gradientDown
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
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
                                  fontSize: _large_font_size,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                        },
                      ),
                    ],
                  )),
              Container(
                height: 25,
              ),
              _tripCardContainerList(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(),
              // ),
              _cardContainerList(),
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
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 10,
                                  offset: Offset(0, 5))
                            ],
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(15)),
                        alignment: Alignment(0, 0),
                        child: FlatButton(
                          onPressed: () {
                            print("pressed");
                            if (!open) {
                              transformation = rotateBy_0;
                              borderRadius = BorderRadius.circular(0);
                              myHeight = MediaQuery.of(context).size.height;
                              myWidth = MediaQuery.of(context).size.width;
                              open = true;
                            } else {
                              open = false;
                              myHeight = 300.0;
                              myWidth = 300.0;
                              transformation = rotateBy45;
                              borderRadius = BorderRadius.circular(100);
                            }
                            setState(() {});
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
