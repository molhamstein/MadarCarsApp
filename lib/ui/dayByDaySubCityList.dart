import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';

class dayByDaySubCityList extends StatefulWidget {
  SubLocationResponse subLocationResponse;

  final Function(String, int, int, String) onCounterChanged;

  dayByDaySubCityList(this.subLocationResponse, this.onCounterChanged);

  @override
  _dayByDaySubCityListState createState() => _dayByDaySubCityListState();
}

class _dayByDaySubCityListState extends State<dayByDaySubCityList> {
  int _counter;
  TripPlaningBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<TripPlaningBloc>(context);
    _counter = bloc.trip
        .getSubLocationDurationById(widget.subLocationResponse.subLocationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Row(
      children: <Widget>[
        Column(
          children: <Widget>[new Text("12/12/2012"), new Text("12/12/2012")],
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                widget.subLocationResponse.subLocation.nameEn,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Text((_counter.toString() +
                      "*" +
                      (widget.subLocationResponse.cost).toString()) +
                  "->" +
                  ((_counter) * widget.subLocationResponse.cost).toString()),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  setState(() {
                    if (!bloc.trip.isMaxDuration()) {
                      _counter++;
                      widget.onCounterChanged(
                          widget.subLocationResponse.subLocation.id,
                          _counter,
                          widget.subLocationResponse.cost,
                          widget.subLocationResponse.subLocation
                              .name(MadarLocalizations.of(context).locale));
                      bloc.pushEstimationCost;
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
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    if (_counter > 0) {
                      _counter--;
                      widget.onCounterChanged(
                          widget.subLocationResponse.subLocation.id,
                          _counter,
                          widget.subLocationResponse.cost,
                          widget.subLocationResponse.subLocation
                              .name(MadarLocalizations.of(context).locale));
                      bloc.pushEstimationCost;
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
  }
}
