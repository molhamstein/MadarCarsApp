import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/trip_info_page.dart';

class MyTripCard extends StatelessWidget {
  final MyTrip trip;
  MyTripCard(this.trip);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TripInfoPage(trip),
          ),
        );
      },
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
                            color: trip.isActive()
                                ? Colors.yellow.shade800
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: trip.isActive()
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
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
                            "${DateFormat.Md().format(DateTime.parse(trip.startDate()))}\n${DateFormat.y().format(DateTime.parse(trip.startDate()))}",
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
                                                    trip.location.nameEn,
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
                                              padding:
                                                  const EdgeInsets.all(12.0),
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
                                                        color: Colors
                                                            .grey.shade800),
                                                    maxLines: 1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: AutoSizeText(
                                                      "${trip.totlaDuration()} Days",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
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
                                                        trip.car.name,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,
                                                      ),
                                                      AutoSizeText(
                                                        '${trip.driver.firstName} ${trip.driver.lastName}',
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
                                                            trip.startDate(),
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
                                                              trip.endDate(),
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
}
