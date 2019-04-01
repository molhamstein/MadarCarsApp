import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/trip_planning/bloc/choose_sub_city_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/ui/DayByDaySubCityTile.dart';

class DayByDayPage extends StatefulWidget {
  @override
  DayByDayPageState createState() {
    return new DayByDayPageState();
  }
}

class DayByDayPageState extends State<DayByDayPage>
    with TickerProviderStateMixin {
  ChooseSubCityBloc bloc;
  TripPlaningBloc planingBloc;
  AnimationController _controller;
  AnimationController _subCitiesController;

  Animation<Offset> _offsetFloat;
  Animation<Offset> _subCitiesFloat;

  static List<SubLocationResponse> subList = [];

  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseSubCityBloc(
        planingBloc.trip, BlocProvider.of<AppBloc>(context).token);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _subCitiesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 200), end: Offset.zero)
        .animate(curvedAnimation);

    _offsetFloat.addListener(() {
      setState(() {});
    });
    final CurvedAnimation curvedAnimation2 = CurvedAnimation(
        parent: _subCitiesController, curve: ElasticOutCurve(0.5));

    _subCitiesFloat = Tween<Offset>(begin: Offset(700, 0), end: Offset.zero)
        .animate(curvedAnimation2);
    _subCitiesFloat.addListener(() {
      setState(() {});
    });

    _controller.forward();

    Future.delayed(Duration(seconds: 1)).then((_) {
      _subCitiesController.forward();
    });

    bloc.pushSubLocations;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var estimCost = planingBloc.trip.estimationPrice();
    print("estim Cost in build $estimCost");
    return Material(
      color: Colors.transparent,
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
                      Container(
                        margin: EdgeInsets.only(right: 24, left: 24),
                        height: MediaQuery.of(context).size.height - 120,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(right: 16, left: 16, top: 16),
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
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        MadarLocalizations.of(context)
                                            .trans('estim_cost'),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        StreamBuilder<int>(
                                            stream:
                                                planingBloc.estimationStream,
                                            initialData: estimCost,
                                            builder: (context, snapshot) {
                                              print(
                                                  "estim Cost in stream ${snapshot.data}");
                                              return Text(
                                                snapshot.data.toString(),
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 60,
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.5),
                                              );
                                            }),
                                        Text(
                                          '\$',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: subList.length,
                                      itemBuilder: (context, int index) {
//                                    return  dayByDaySubCityList(subList[index] ,planingBloc.addSubLocation) ;
                                        int _counter;

                                        _counter = planingBloc.trip
                                            .getSubLocationDurationById(
                                                subList[index].subLocationId);
                                        int _dateCounter = _counter ;
                                        DateTime endDate= (planingBloc.trip.startDate) ;
                                        ;
                                        return new Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                index == 0 ?
                                                new Text((planingBloc.trip.startDate).toString()):Text(endDate.add(new Duration(days:_counter +1 )).toString()),
                                                index == 0 ?
                                                new Text((endDate.add(new Duration(days:_counter ))  ).toString()):Text("")
                                        ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    subList[index]
                                                        .subLocation
                                                        .nameEn,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text((_counter.toString() +
                                                          "*" +
                                                          (subList[index].cost)
                                                              .toString()) +
                                                      "->" +
                                                      ((_counter) *
                                                              subList[index]
                                                                  .cost)
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (!planingBloc.trip
                                                            .isMaxDuration()) {
                                                          _counter++;
                                                          planingBloc.addSubLocation(
                                                              subList[index]
                                                                  .subLocation
                                                                  .id,
                                                              _counter,
                                                              subList[index]
                                                                  .cost,
                                                              subList[index]
                                                                  .subLocation
                                                                  .name(MadarLocalizations.of(
                                                                          context)
                                                                      .locale));
                                                          planingBloc
                                                              .pushEstimationCost;
                                                        }
                                                      });
                                                    },
                                                    child: new Icon(
                                                      Icons.arrow_drop_up,
                                                      size: 40,
                                                    )),
                                                new Text(
                                                  _counter.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      height: 0.5,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (_counter > 0) {
                                                          _counter--;
                                                          planingBloc.addSubLocation(
                                                              subList[index]
                                                                  .subLocation
                                                                  .id,
                                                              _counter,
                                                              subList[index]
                                                                  .cost,
                                                              subList[index]
                                                                  .subLocation
                                                                  .name(MadarLocalizations.of(
                                                                          context)
                                                                      .locale));
                                                          planingBloc
                                                              .pushEstimationCost;
                                                        }
                                                      });
                                                    },
                                                    child: new Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 40,
                                                    ))
                                              ],
                                            ),
                                            new Text("days")
                                          ],
                                        );
                                      }),
                                ),

//                            subList.length != 0 ?
//                            dayByDaySubCityList(subList[0] ,planingBloc.addSubLocation): Container(),

//                Padding(
//                  padding: const EdgeInsets.only(top: 30, right: 32, left: 32),
//                  child: Text(
//                    MadarLocalizations.of(context).trans('step_five_title'),
//                    style: TextStyle(
//                        color: Colors.grey[700],
//                        fontSize: 18,
//                        fontWeight: FontWeight.w600,
//                        height: 0.8),
//                  ),
//                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            AnimatedBuilder(
                                animation: _subCitiesFloat,
                                builder: (context, widget) {
                                  return Transform.translate(
                                    offset: _subCitiesFloat.value,
                                    child: StreamBuilder<
                                        List<SubLocationResponse>>(
                                      stream: bloc.subLocationsStream,
                                      // initialData: [],
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40.0, right: 40),
                                                child: Row(
                                                  children: <Widget>[
                                                    new Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans(
                                                              'Want_to_visit_other_cities_too'),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 40),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                      height: 120,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: snapshot
                                                              .data.length,
                                                          itemBuilder: (context,
                                                              int index) {
                                                            return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    print(snapshot
                                                                        .data[
                                                                            index]
                                                                        .subLocation
                                                                        .nameEn);
                                                                    subList.add(
                                                                        snapshot
                                                                            .data[index]);
                                                                    print("here i am" +
                                                                        subList
                                                                            .toString());
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 4.0,
                                                                      right: 4),
                                                                  child: Wrap(
                                                                      spacing:
                                                                          16,
                                                                      runSpacing:
                                                                          16,
                                                                      children: <Widget>[
                                                                        DayByDaySubCityTile(
                                                                            subLocationResponse:
                                                                                snapshot.data[index])
                                                                      ]),
                                                                ));
                                                          }),

//                                                      child: ListView.builder(
//                                                        scrollDirection:
//                                                            Axis.horizontal,
//                                                        itemCount: 1,
//                                                        itemBuilder:
//                                                            (BuildContext
//                                                                    context,
//                                                                index) {
//                                                          return Wrap(
//                                                              crossAxisAlignment:
//                                                                  WrapCrossAlignment
//                                                                      .start,
//                                                              spacing: 16,
//                                                              runSpacing: 16,
//                                                              children: snapshot
//                                                                  .data
//                                                                  .map((subLocationResponse) =>
//                                                                      DayByDaySubCityTile(
////                                                        onCounterChanged:
////                                                            planingBloc
////                                                                .addSubLocation,
//                                                                        subLocationResponse:
//                                                                            subLocationResponse,
//                                                                      ))
//                                                                  .toList());
//                                                        },
//                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  );
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

//  _tilesShimmer() {
//    return Container(
//      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
//      height: MediaQuery.of(context).size.width / 2,
//      child: ListView.builder(
//        padding: EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
//        itemCount: 1,
//        scrollDirection: Axis.horizontal,
//        itemBuilder: (context, index) {
//          return Shimmer.fromColors(
//            baseColor: Colors.grey[300],
//            highlightColor: Colors.grey[200],
//            child: Container(
//              margin: EdgeInsets.all(8),
//              width: MediaQuery.of(context).size.width / 2.5,
//              height: MediaQuery.of(context).size.width / 2.5,
//              color: Colors.grey[300],
//            ),
//          );
//        },
//      ),
//    );
//  }
}
