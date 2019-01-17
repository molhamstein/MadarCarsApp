import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/date_picker.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/vertical_devider.dart';

class StepChooseDatePage extends StatelessWidget {


  bool fromAirport;
  bool toAirport;
  bool cityTour;

  TripPlaningBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TripPlaningBloc>(context);
    fromAirport = bloc.isFromAirport;
    toAirport = bloc.isToAirport;
    cityTour = bloc.isCityTour;
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60, right: 24, left: 24),
            height: MediaQuery
                .of(context)
                .size
                .height - 250,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.only(right: 16, left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Select below the dates when you need the car',
                    style: TextStyle(fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w700),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _layout(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> _layout() {
    if (cityTour || (fromAirport && toAirport)) {
      return [
        _startDate(),
        MadarVerticalDivider(height: 70, color: Colors.black54),
        _endDate()
      ];
    } else if (fromAirport) return [_startDate()];
    else if (toAirport) return [_endDate()];

  }

  _startDate() {
    return DatePicker(
      title: 'Start Date',
      withTimePicker: fromAirport,
      onDateChanged: bloc.startDateChanged,
    );
  }

  _endDate() {
    return DatePicker(
      title: 'End Date',
      withTimePicker: toAirport,
      onDateChanged: bloc.endDateChanged,
    );
  }

}
