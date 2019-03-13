import 'package:flutter/material.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';

class check extends StatefulWidget {
  @override
  _checkState createState() => _checkState();
}

class _checkState extends State<check> {
  TextEditingController _controller = new TextEditingController();
  TripPlaningBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextField(
          controller: _controller,
          onSubmitted: (s){
            bloc.checkNum(s);
          },
        ),
      ),
    );
  }
}
