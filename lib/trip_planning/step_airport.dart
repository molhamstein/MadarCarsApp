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
                    initialData: 0,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print("preesed");
                                airportBloc.selectAirpory(index);
                              },
                              child: Transform.translate(
                                offset: _offsetFloat.value,
                                child: TripTypeTile(
                                  title: MadarLocalizations.of(context)
                                      .trans('pickup_from_airport'),
                                  iconData: FontAwesomeIcons.planeArrival,
                                  // onChecked: bloc.fromAirport,
                                  checked: index == snapshot.data,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        MadarLocalizations.of(context)
                            .trans('trip_planing_question'),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoadingButtonSmall(
                          height: 30,
                          width: 170,
                          text: MadarLocalizations.of(context).trans('call_us'),
                          loading: true,
                          onPressed: () {
                            bloc.submitHelp();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
