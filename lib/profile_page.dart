import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/settings_page.dart';
import 'package:madar_booking/trip_info_page.dart';
import 'madar_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'my_flutter_app_icons.dart';

class ProfilePage extends StatelessWidget {
  Widget tripInfoCard() {
    return InkWell(
      child: Container(
        // width: 300,
        height: 200,

        child: Row(
          children: <Widget>[
            // time container
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 8.0),
                          child: Container(
                            height: 175,
                            width: 1.0,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      // width: 50,
                      // color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          AutoSizeText(
                            "12/12\n2018",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900),
                            maxLines: 2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // card container
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Container(
                    // color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          // decoration: BoxDecoration(
                          //   boxShadow: [MadarColors.shadow],
                          //   borderRadius: BorderRadius.circular(12.5),
                          // ),
                          height: 160,
                          //card info container
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/card-01.png'),
                                  fit: BoxFit.fill),
                              boxShadow: [MadarColors.shadow],
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.5),
                                  topLeft: Radius.circular(12.5)),
                            ),
                            // card info conatiner row
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  // location and duration container
                                  child: Container(
                                    // color: Colors.red,
                                    child: Column(
                                      children: <Widget>[
                                        // location container
                                        Expanded(
                                          child: Container(
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  right: 12.0,
                                                  top: 16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    "Borsa",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .grey.shade800),
                                                    maxLines: 1,
                                                  ),
                                                  AutoSizeText(
                                                    "Picked From Airport",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                    maxLines: 2,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // duration container
                                        Expanded(
                                            child: Container(
                                          // color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                AutoSizeText(
                                                  "Duration",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade800),
                                                  maxLines: 1,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: AutoSizeText(
                                                    "2 Days",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                // medile container
                                Container(
                                  child: Container(
                                    color: Colors.grey.shade600,
                                    height: 115,
                                    width: 1,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Stack(children: <Widget>[
                                    Container(
                                      // color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient:
                                                MadarColors.gradiant_decoration,
                                          ),
                                          // car and driver info container
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      AutoSizeText(
                                                        "Mercedes E16",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,
                                                      ),
                                                      AutoSizeText(
                                                        "Mahmout Orhan",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // from - to  date container
                                              Container(
                                                // color: Colors.red,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    // from date container
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          AutoSizeText(
                                                            "From",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.grey
                                                                  .shade800,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                          AutoSizeText(
                                                            "12/12/2018",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // to date container
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                            child: AutoSizeText(
                                                              "To",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: AutoSizeText(
                                                              "14/12/2018",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 75),
                                        width: 200,
                                        height: 2,
                                        color: Colors.white,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          )),
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

  Widget tripInfoCardList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 10,
        // itemExtent: 10.0,
        // reverse: true, //makes the list appear in descending order
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TripInfoPage()));
              },
              child: tripInfoCard());
        });
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
          image: AssetImage('assets/images/profileImg.png'),
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              decoration: BoxDecoration(
                  borderRadius: borderRaduice,
                  gradient: MadarColors.gradiant_decoration),
              height: myHeight,
              width: myWidth,
              transform: transformation,
            ),
          ),
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
                      Container(
                        // color: Colors.blue,
                        height: 122.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
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
                      )
                    ],
                  ),
                ),
                Container(
                  // color: Colors.red,
                  constraints: BoxConstraints.expand(height: 30.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your bookings",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: tripInfoCardList(),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      MyFlutterApp.edit_profile,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
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
              ))
        ],
      ),
    );
  }
}
