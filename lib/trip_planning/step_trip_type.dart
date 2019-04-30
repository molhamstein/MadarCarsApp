import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/LoadingButtonSmall.dart';
import 'package:madar_booking/TripTypeTile.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';

class TripTypeStep extends StatefulWidget {
  @override
  TripTypeStepState createState() {
    return new TripTypeStepState();
  }
}

class TripTypeStepState extends State<TripTypeStep>
    with TickerProviderStateMixin {
  TripPlaningBloc bloc;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  @override
  void initState() {
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
    bloc = BlocProvider.of<TripPlaningBloc>(context);
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
                    MadarLocalizations.of(context).trans('step_two_title'),
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Container(
                  height: 40,
                ),
                Transform.translate(
                  offset: _offsetFloat.value,
                  child: TripTypeTile(
                    title: MadarLocalizations.of(context)
                        .trans('pickup_from_airport'),
                    iconData: FontAwesomeIcons.planeArrival,
                    onChecked: bloc.fromAirport,
                    checked: bloc.trip.fromAirport,
                  ),
                ),
                Transform.translate(
                  offset: _offsetFloat.value * 1.2,
                  child: TripTypeTile(
                    title: MadarLocalizations.of(context)
                        .trans('rent_car_for_city_tour'),
                    iconData: FontAwesomeIcons.car,
                    onChecked: bloc.cityTour,
                    checked: bloc.trip.inCity,
                  ),
                ),
                Transform.translate(
                  offset: _offsetFloat.value * 1.4,
                  child: TripTypeTile(
                    title: MadarLocalizations.of(context)
                        .trans('pickup_to_airport'),
                    iconData: FontAwesomeIcons.planeDeparture,
                    onChecked: bloc.toAirport,
                    checked: bloc.trip.toAirport,
                  ),
                ),
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
