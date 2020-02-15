import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madar_booking/app_text_style.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/trip_info_page.dart';

class MyTripCard extends StatefulWidget {
  final MyTrip trip;

  MyTripCard(this.trip);

  @override
  MyTripCardState createState() {
    return new MyTripCardState();
  }
}

class MyTripCardState extends State<MyTripCard> {
  String getTripStatus() {
    if (widget.trip.fromAirport &&
        widget.trip.inCity &&
        widget.trip.toAirport) {
      return MadarLocalizations.of(context).trans('tow_way_air_port');
    } else if (widget.trip.fromAirport && widget.trip.inCity) {
      return MadarLocalizations.of(context).trans('from_air_port') ;
    } else if (widget.trip.fromAirport && widget.trip.toAirport) {
      return MadarLocalizations.of(context).trans('tow_way_air_port');
    } else if (widget.trip.inCity && widget.trip.toAirport) {
      return MadarLocalizations.of(context).trans('to_air_port') ;
    }
    return '';
  }

  String getTripPlace() {
    if (widget.trip.fromAirport &&
        widget.trip.inCity &&
        widget.trip.toAirport) {
      return
          MadarLocalizations.of(context).trans('in_city');
    } else if (widget.trip.fromAirport && widget.trip.inCity) {
      return
          MadarLocalizations.of(context).trans('in_city');
    } else if (widget.trip.fromAirport && widget.trip.toAirport) {
      return '';
    } else if (widget.trip.inCity && widget.trip.toAirport) {
      return
          MadarLocalizations.of(context).trans('in_city');
    }
    return '';
  }



  @override
  Widget build(BuildContext context) {
    print(widget.trip.startDateFromated());
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TripInfoPage(widget.trip),
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
                            color: widget.trip.isActive()
                                ? Colors.yellow.shade800
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: widget.trip.isActive()
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 10.0, end: 8.0),
                          child: Container(
                            height: 175,
                            width: 1.0,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 4),
                      // width: 50,
                      // color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AutoSizeText(
                              "${DateFormat.Md().format(DateTime.parse(widget.trip.startDate()))}",
                              style: AppTextStyle.smallTextStyleBlack,
                              maxLines: 2,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AutoSizeText(
                              "${DateFormat.y().format(DateTime.parse(widget.trip.startDate()))}",
                              style: AppTextStyle.smallTextStyleBlack,
                              maxLines: 2,
                            ),
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
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: Container(
                          // decoration: BoxDecoration(
                          //   boxShadow: [MadarColors.shadow],
                          //   borderRadius: BorderRadius.circular(12.5),
                          // ),
                          height: 160,
                          //card info container
                          child: Container(
                            margin: EdgeInsetsDirectional.only(end: 8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/card-01.png'),
                                  fit: BoxFit.fill,
                                  matchTextDirection: true),
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 12.0,
                                                      end: 12.0,
                                                      top: 16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: AutoSizeText(
                                                      widget.trip.location.name(
                                                          MadarLocalizations.of(
                                                                  context)
                                                              .locale),
                                                      style: AppTextStyle
                                                          .largeTextStyleBlack,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: AutoSizeText(
                                                      getTripStatus(),
                                                      style: AppTextStyle
                                                          .smallTextStylegrey,
                                                      maxLines: 2,
                                                    ),
                                                  )

                                                  ,
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: AutoSizeText(
                                                      getTripPlace(),
                                                      style: AppTextStyle
                                                          .smallTextStylegrey,
                                                      maxLines: 2,
                                                    ),
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: AutoSizeText(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans("duration"),
                                                      style: AppTextStyle
                                                          .largeTextStyleBlack,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: AutoSizeText(
                                                      "${widget.trip.totlaDuration()} ${MadarLocalizations.of(context).trans("days")}",
                                                      style: AppTextStyle
                                                          .smallTextStylegrey,
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: AutoSizeText(
                                                          widget.trip.car.brand.name(
                                                              MadarLocalizations
                                                                      .of(context)
                                                                  .locale),
                                                          style: AppTextStyle
                                                              .normalTextStyleWhite,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: AutoSizeText(
                                                          '${widget.trip.driver.firstName} ${widget.trip.driver.lastName}',
                                                          style: AppTextStyle
                                                              .smallTextStyleWhite,
                                                          maxLines: 1,
                                                        ),
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: AutoSizeText(
                                                              MadarLocalizations
                                                                      .of(
                                                                          context)
                                                                  .trans(
                                                                      "from"),
                                                              style: AppTextStyle
                                                                  .meduimTextStyleBlack,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: AutoSizeText(
                                                              widget.trip
                                                                  .startDateFromated(),
                                                              style: AppTextStyle
                                                                  .xSmallTextStyleWhite,
                                                              maxLines: 1,
                                                            ),
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
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                MadarLocalizations.of(
                                                                        context)
                                                                    .trans(
                                                                        "to"),
                                                                style: AppTextStyle
                                                                    .meduimTextStyleBlack,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                widget.trip
                                                                    .endDateFormated(),
                                                                style: AppTextStyle
                                                                    .xSmallTextStyleWhite,
                                                                maxLines: 1,
                                                              ),
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
                                        margin: EdgeInsetsDirectional.only(
                                            start: 10, end: 75),
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
