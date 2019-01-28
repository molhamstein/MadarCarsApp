import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/app_text_style.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/invoice_page.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/my_flutter_app_icons.dart';
import 'package:madar_booking/rate_widget.dart';
import 'madar_colors.dart';

class TripInfoPage extends StatefulWidget {
  final MyTrip trip;
  TripInfoPage(this.trip);
  @override
  TripInfoPageState createState() => TripInfoPageState(trip);
}

class TripInfoPageState extends State<TripInfoPage> {
  final MyTrip trip;
  TripInfoPageState(this.trip);
  // animated widget height
  double containerWidgetHeight = 200;
  var languages = ["Turkish", "English", "Arabic"];
  var cities = ["Istanbul", "Bursa", "Ankara"];
  var days = ["2 days", "1 day", "1 day"];
// timer for animated widget
  var timeout = const Duration(seconds: 3);
  var ms = const Duration(milliseconds: 1);

  var scaleByOne = new Matrix4.identity()..translate(0.0, 0.0);
  var scaleByZero = new Matrix4.identity()..translate(0.0, 500.0);
  var transformation = new Matrix4.identity()..translate(0.0, 500.0);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    print("time out");
    // containerWidgetHeight = 200;
    transformation = scaleByOne;
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        handleTimeout();
      });
    });
    super.initState();
  }

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
              days,
              style: AppTextStyle.meduimTextStyleBlack,
            ),
          ],
        ),
      ),
    );
  }

  Widget costWidget(String cost) {
    return Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              // estim cost container
              child: Container(
                alignment: Alignment(0, 0),
                child: Text(
                  MadarLocalizations.of(context).trans("estim_cost"),
                  style:
                      MadarLocalizations.of(context).locale.languageCode == 'en'
                          ? AppTextStyle.largeTextStyleBlack
                          : AppTextStyle.meduimTextStyleBlack,
                ),
              ),
            ),
            Expanded(
              // cost container
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 32.0),
                          child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: cost,
                                style: AppTextStyle.xLaragTextStyleBlack,
                              )),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment(0, -1),
                              height: 75,
                              width: 20,
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: "\$",
                                    style: AppTextStyle.smallTextStyleBlack),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(trip.car.media.url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                // gradiant Container
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: MadarColors.gradiant_decoration,
                      ),
                    )),
              ],
            ),
          ),
          // content container
          Container(
            child: Column(
              children: <Widget>[
                // padding container
                Container(
                  height: (MediaQuery.of(context).size.height * 0.35) - 50.0,
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 20.0, end: 20.0),
                    // content container
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      transform: transformation,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [MadarColors.shadow],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0))),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 75.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: RichText(
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                        text: MadarLocalizations
                                                                .of(context)
                                                            .trans(
                                                                "start_date"),
                                                        style: AppTextStyle
                                                            .meduimTextStylegrey,
                                                      ))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  trip.startDateFromated(),
                                                  style: AppTextStyle
                                                      .meduimTextStylegrey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: RichText(
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                        text: MadarLocalizations
                                                                .of(context)
                                                            .trans("end_date"),
                                                        style: AppTextStyle
                                                            .meduimTextStylegrey,
                                                      ))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  trip.endDateFormated(),
                                                  style: AppTextStyle
                                                      .meduimTextStylegrey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment(0, -0.5),
                                          child: trip.hasOuterBill
                                              ? IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    InvoicePage(
                                                                      trip:
                                                                          trip,
                                                                    )));
                                                  },
                                                  icon: Icon(
                                                      MyFlutterApp.invoice),
                                                )
                                              : null,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment(0, -0.5),
                                          child: trip.isActive()
                                              ? IconButton(
                                                  onPressed: () {
                                                    print("edit clicled");
                                                  },
                                                  icon: Icon(
                                                      MyFlutterApp.edit_trip),
                                                )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      trip.car.brand.name(
                                                          MadarLocalizations.of(
                                                                  context)
                                                              .locale),
                                                      style: AppTextStyle
                                                          .largeTextStyleBlack,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      '${trip.driver.firstName} ${trip.driver.lastName}',
                                                      style: AppTextStyle
                                                          .normalTextStylegrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Container(
                                                  alignment: Alignment(1, 0),
                                                  child: RateWidget(
                                                      '${trip.car.rate}'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 16.0),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              itemCount: trip
                                                  .driver.driverLangs.length,
                                              // itemExtent: 10.0,
                                              // reverse: true, //makes the list appear in descending order
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var lang = trip
                                                    .driver.driverLangs[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(end: 8.0),
                                                  child: Container(
                                                      alignment:
                                                          Alignment(0, 0),
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(
                                                                  start: 10.0,
                                                                  end: 10.0),
                                                      decoration: BoxDecoration(
                                                        color: MadarColors
                                                            .gradientDown,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 4.0),
                                                          child: Text(
                                                            lang.language.name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                .meduimTextStyleWhite,
                                                          ),
                                                        ),
                                                      )),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  child: Container(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          child: InkWell(
                                            onTap: () {
                                              print("pressed icon button");
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  MyFlutterApp.cal,
                                                  size: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                      trip.car.productionDate
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade700)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                          child: Container(
                                            child: InkWell(
                                              onTap: () {
                                                print("pressed icon button");
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    MyFlutterApp.gender,
                                                    size: 30,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                        "${trip.driver.gender} Driver",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey
                                                                .shade700)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: InkWell(
                                              onTap: () {
                                                print("pressed icon button");
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    MyFlutterApp.seats,
                                                    size: 30,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                        "${trip.car.numOfSeat} ${MadarLocalizations.of(context).trans("seats")}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey
                                                                .shade700)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: <Widget>[
                                        citiesListRow(
                                            trip.location.name(
                                                MadarLocalizations.of(context)
                                                    .locale),
                                            '${trip.daysInCity}'),
                                        ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount:
                                                trip.tripSublocations.length,
                                            // itemExtent: 10.0,
                                            // reverse: true, //makes the list appear in descending order
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var location =
                                                  trip.tripSublocations[index];
                                              return citiesListRow(
                                                  location.subLocation.nameEn,
                                                  '${location.duration}');
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  child: costWidget("${trip.cost}"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[],
            ),
          ),
        ],
      ),
    );
  }
}
