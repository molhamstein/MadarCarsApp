import 'package:flutter/material.dart';
import 'package:madar_booking/app_text_style.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/main.dart';
import 'package:madar_booking/models/CouponModel.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';

class StepSummary extends StatefulWidget {
  @override
  StepSummaryState createState() {
    return new StepSummaryState();
  }
}

class StepSummaryState extends State<StepSummary>
    with TickerProviderStateMixin, Network, UserFeedback {
  TripPlaningBloc planingBloc;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  // Trip trip;

  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 200), end: Offset.zero)
        .animate(curvedAnimation);

    _offsetFloat.addListener(() {
      setState(() {});
    });

    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext mContext) {
    TextEditingController _haveCoponController = new TextEditingController();

    List<String> startDate = planingBloc.trip.startDate.toString().split(" ");
    String sDate = startDate[0].replaceAll("-", "/");
    print(sDate);
    List<String> endDate = planingBloc.trip.endDate.toString().split(" ");
    String eDate = endDate[0].replaceAll("-", "/");
    print(endDate);

    final TextStyle infoLabelStyle = TextStyle(
        color: Colors.grey[700],
        fontSize: isScreenLongEnough ? 16 : 12,
        fontWeight: FontWeight.w700,
        height: 0.8);
    final double iconSize = 18;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedBuilder(
                animation: _offsetFloat,
                builder: (context, widget) {
                  return Transform.translate(
                    offset: _offsetFloat.value,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 24, left: 24),
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.only(right: 16, left: 16, top: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                      bottom: 40,
                                    ),
                                    child: new Row(
                                      children: <Widget>[
                                        Text(
                                          MadarLocalizations.of(context)
                                              .trans('Summary'),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              height: 0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      children: <Widget>[
                                        new Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            new Text(
                                                MadarLocalizations.of(context)
                                                    .trans("start_date"),
                                                style: TextStyle(
                                                    color:
                                                        MadarColors.grey[600],
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    height: 0.5)),
                                            Text(sDate,
                                                style: TextStyle(
                                                    color:
                                                        MadarColors.dark_grey,
                                                    fontWeight:
                                                        FontWeight.w700))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  new Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans("end_date"),
                                                      style: TextStyle(
                                                          color: MadarColors
                                                              .grey[600],
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 0.5)),
                                                ],
                                              ),
                                              Text(
                                                eDate,
                                                style: TextStyle(
                                                    color:
                                                        MadarColors.dark_grey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 40.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                new Text(
                                                  planingBloc.trip.car.name,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: MadarColors
                                                          .grey[800]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25.0),
                                                  child: new Text(
                                                    planingBloc.trip.car.driver
                                                            .firstName +
                                                        " " +
                                                        planingBloc.trip.car
                                                            .driver.lastName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: MadarColors
                                                            .grey[600]),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                new Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    new Text(
                                                      planingBloc
                                                          .trip.car.pricePerDay
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: MadarColors
                                                              .grey[800]),
                                                    ),
                                                    new Text("\$")
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25.0),
                                                  child: Container(
                                                      child: Row(
                                                    children: <Widget>[
                                                      new Text("/"),
                                                      new Text(
                                                          MadarLocalizations.of(
                                                                  context)
                                                              .trans("day")),
                                                    ],
                                                  )),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 250.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 35.0, right: 35),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Text(
                                            MadarLocalizations.of(context)
                                                .trans("Airport_Pick_up"),
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                height: 0.5)),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) -
                                            32,
                                        alignment: Alignment.center,
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(14.0)),
                                      ),
                                    ),
/////////////////////
                                    Container(
                                      // height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: <Widget>[
                                            citiesListRow(
                                                planingBloc.trip.location.name(
                                                    MadarLocalizations.of(
                                                            context)
                                                        .locale),
                                                '${planingBloc.trip.tripDuration().toString()}'),
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                itemCount: planingBloc.trip
                                                    .tripSubLocations.length,
                                                // itemExtent: 10.0,
                                                // reverse: true, //makes the list appear in descending order
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var location = planingBloc
                                                      .trip
                                                      .tripSubLocations[index];
                                                  return citiesListRow(
                                                      location
                                                          .subLocation.nameTr,
                                                      '${location.duration}');
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),

//                                    ////////////////
                                  ],
                                ),
                              ),
                              StreamBuilder<Coupon>(
                                  stream: planingBloc.couponStream,
                                  builder: (context, snapshot) {
                  /*                  if (snapshot.hasError) {
                                      print("Errrrrrrrrrrrrrrror");
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showInSnackBar(
                                            'Wrong_Coupon_Code', mContext,
                                            color: Colors.red);
                                      });
                                    }*/
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, right: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    padding: EdgeInsets.all(16),
                                                    color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              bottom: MediaQuery
                                                                      .of(context)
                                                                  .viewInsets
                                                                  .bottom),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.5,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right: 8),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        _haveCoponController,

                                                                    autofocus:
                                                                        true,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hasFloatingPlaceholder:
                                                                          true,
                                                                      hintText: MadarLocalizations.of(
                                                                              context)
                                                                          .trans(
                                                                              'Enter_Your_Coupon'),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              RaisedButton(
                                                                child: new Text(
                                                                    MadarLocalizations.of(
                                                                            context)
                                                                        .trans(
                                                                            'Check')),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  planingBloc.fetchCoupon(
                                                                      _haveCoponController
                                                                          .text);
                                                                  print("data is " +
                                                                      snapshot
                                                                          .data
                                                                          .id);
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: new Text(
                                                MadarLocalizations.of(context)
                                                    .trans(
                                                        "Have_a_Coupon_Code"),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    height: 0.5)),
                                            color: MadarColors.gradientDown,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 35.0, right: 35),
                                child: StreamBuilder<Coupon>(
                                    stream: planingBloc.couponStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        print(
                                            "I'm heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeere");
                                      } 
                                      if (snapshot.hasData) {
                                        planingBloc.trip.couponId =
                                            snapshot.data.id;
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: Column(
                                            children: <Widget>[
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  new Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans("Discount"),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0.5)),
                                                  new Row(
                                                    children: <Widget>[
                                                      snapshot.data.type ==
                                                              "percentage"
                                                          ? Text(
                                                              ((snapshot.data.value / 100) *
                                                                      planingBloc.trip
                                                            .estimationPrice())
                                                            .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: MadarColors.grey[
                                                                      800]))
                                                          : Text(((snapshot.data.value)).toString(),
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: MadarColors
                                                                      .grey[800])),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 15.0),
                                                          child:
                                                              new Text("\$")),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  new Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans("estim_cost"),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0.5)),
                                                  new Row(
                                                    children: <Widget>[
                                                      snapshot.data.type ==
                                                              "percentage"
                                                          ? new Text(
                                                              (planingBloc.trip
                                                                      .estimationPriceWithPercentageDiscount(snapshot
                                                                          .data
                                                                          .value))
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: MadarColors
                                                                          .grey[
                                                                      800]))
                                                          :new Text(
                                                              (planingBloc.trip.estimationPrice() -
                                                                  snapshot.data
                                                                      .value)
                                                              .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: MadarColors
                                                                          .grey[
                                                                      800])),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 15.0),
                                                        child: new Text("\$"),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      } else 
                                        return Column(
                                          children: <Widget>[
//                                            new SizedBox(height: 80,),
                                            new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                new Text(
                                                    MadarLocalizations.of(
                                                            context)
                                                        .trans("estim_cost"),
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0.5)),
                                                new Row(
                                                  children: <Widget>[
                                                    new Text(
                                                        planingBloc.trip
                                                            .estimationPrice()
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: MadarColors
                                                                .grey[800])),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 15.0),
                                                      child: new Text("\$"),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

//
  Widget citiesListRow(String city, String days) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      height: 60,
      child: InkWell(
        onTap: () {
          print("pressed");
        },
        child: Row(
          children: <Widget>[
            Text(
              city,
              style: AppTextStyle.meduimTextStyleBlack,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              days + " " + MadarLocalizations.of(context).trans("day"),
              style: AppTextStyle.meduimTextStyleBlack,
            ),
          ],
        ),
      ),
    );
  }
}
