import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/LoadingButtonSmall.dart';
import 'package:madar_booking/TripTypeTile.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/trip_planning/bloc/choose_airpory_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/need_help_page.dart';

class AirportStep extends StatefulWidget {
  @override
  AirportStepState createState() {
    return new AirportStepState();
  }
}

class AirportStepState extends State<AirportStep>
    with TickerProviderStateMixin {
  TripPlaningBloc bloc;
  ChooseAirportBloc airportBloc;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  @override
  void initState() {
    bloc = BlocProvider.of<TripPlaningBloc>(context);
    airportBloc =
        ChooseAirportBloc(bloc.trip, BlocProvider.of<AppBloc>(context).token);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(200, 0.0), end: Offset.zero)
        .animate(curvedAnimation);

    _offsetFloat.addListener(() {
      setState(() {});
    });

    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: AnimatedBuilder(
          animation: _offsetFloat,
          builder: (context, widget) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    MadarLocalizations.of(context).trans('airport_step_title'),
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Container(
                  height: 40,
                ),
                StreamBuilder<int>(
                    stream: airportBloc.indexStream,
                    // initialData: 0,
                    builder: (context, snapshot) {
                      return AnimatedBuilder(
                          animation: _offsetFloat,
                          builder: (context, widget) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: bloc.airports.length,
                              itemBuilder: (BuildContext context, int index) {
                                var _checked = index == snapshot.data;
                                return GestureDetector(
                                    onTap: () {
                                      print("taaped");
                                      airportBloc.selectAirport(
                                          bloc.airports[index], index);
                                    },
                                    child: Transform.translate(
                                      offset: _offsetFloat.value,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        margin: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 15,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Stack(
                                              children: <Widget>[
                                                _checked
                                                    ? Align(
                                                        alignment: MadarLocalizations.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode ==
                                                                'en'
                                                            ? Alignment.topRight
                                                            : Alignment.topLeft,
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .solidCheckCircle,
                                                          color: Colors
                                                              .yellow[700],
                                                        ),
                                                      )
                                                    : Container(),
                                                Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Icon(FontAwesomeIcons
                                                          .planeArrival),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 32.0,
                                                                right: 32),
                                                        child: Text(
                                                          bloc.airports[index].name(
                                                              MadarLocalizations
                                                                      .of(context)
                                                                  .locale),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    //   Text(
                                    // bloc.airports[index].nameAr,
                                    // style: TextStyle(
                                    //     color: index == snapshot.data
                                    //         ? Colors.red
                                    //         : Colors.white)),
                                    );
                              },
                            );
                          });
                    }),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
