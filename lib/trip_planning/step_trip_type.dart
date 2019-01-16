import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/TripTypeTile.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';

class TripTypeStep extends StatelessWidget {

  TripPlaningBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TripPlaningBloc>(context);
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tell us what do you need',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            Container(height: 40,),
            TripTypeTile(
              title: 'Pickup from Airport',
              iconData: FontAwesomeIcons.planeArrival,
              onChecked: bloc.fromAirport,
            ),
            TripTypeTile(
              title: 'Rent a car for city tour',
              iconData: FontAwesomeIcons.car,
              onChecked: bloc.cityTour,
            ),
            TripTypeTile(
              title: 'Pickup back to Airport',
              iconData: FontAwesomeIcons.planeDeparture,
              onChecked: bloc.toAirport,
            ),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Text(
                'Don\'t know how to plan a trip and need help?',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

}