import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/date_picker.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/vertical_devider.dart';

class StepChooseDatePage extends StatefulWidget {


  @override
  StepChooseDatePageState createState() {
    return new StepChooseDatePageState();
  }
}

class StepChooseDatePageState extends State<StepChooseDatePage> with TickerProviderStateMixin{
  bool fromAirport;

  bool toAirport;

  bool cityTour;

  TripPlaningBloc bloc;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  @override
  void initState() {

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 200), end: Offset.zero)
        .animate(curvedAnimation);

    _offsetFloat.addListener((){
      setState((){});
    });

    _controller.forward();


    super.initState();
  }


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
          Expanded(
            child: AnimatedBuilder(
              animation: _offsetFloat,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _offsetFloat.value,
                  child: Container(
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
                          Text(MadarLocalizations.of(context).trans('step_three_title'),
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
                );
              },
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
      title: MadarLocalizations.of(context).trans('start_date'),
      withTimePicker: fromAirport,
      onDateChanged: bloc.startDateChanged,
      date: bloc.trip.startDate,
    );
  }

  _endDate() {
    return DatePicker(
      title: MadarLocalizations.of(context).trans('end_date'),
      withTimePicker: toAirport,
      onDateChanged: bloc.endDateChanged,
      date: bloc.trip.endDate,
      endOfDay: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
