import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/date_picker.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/vertical_devider.dart';

class StepChooseDatePage extends StatefulWidget {
  static String endDate = "";
  static String startDate = "";

  @override
  StepChooseDatePageState createState() {
    return new StepChooseDatePageState();
  }
}

class StepChooseDatePageState extends State<StepChooseDatePage>
    with TickerProviderStateMixin {
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

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 200), end: Offset.zero)
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
    fromAirport = bloc.isFromAirport;
    toAirport = bloc.isToAirport;
    cityTour = bloc.isCityTour;
    return StreamBuilder<bool>(
        stream: bloc.dateChangedStream,
        builder: (context, snapshot) {
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
                          height: MediaQuery.of(context).size.height - 250,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 16, left: 16),
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
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 120, top: 60),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  MadarLocalizations.of(context)
                                      .trans('step_three_title'),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
        });
  }

  List<Widget> _layout() {
    if (cityTour || (fromAirport && toAirport)) {
      return [
        _startDate(),
        MadarVerticalDivider(height: 70, color: Colors.black54),
        // _endDate()
        StreamBuilder<DateTime>(
            stream: bloc.endtDateStream,
            initialData: DateTime.now(),
            builder: (context, snapshot) {
              print(snapshot.data);

              return DatePicker(
                title: MadarLocalizations.of(context).trans('end_date'),
                withTimePicker: toAirport,
                onDateChanged: (e) {
                  bloc.endDateChanged(e);
                  setState(() {});
                },
                date: snapshot.data,
                endOfDay: true,
              );
            })
      ];
    } else if (fromAirport)
      return [_startDate()];
    else if (toAirport) return [_endDate()];
  }

  _startDate() {
//    StepChooseDatePage.startDate =_startDate();
    var startDate = bloc.trip.startDate;

    return StreamBuilder<DateTime>(
        stream: bloc.startDateStream,
        initialData: DateTime.now(),
        builder: (context, snapshot) {
          return DatePicker(
            title: MadarLocalizations.of(context).trans('start_date'),
            withTimePicker: fromAirport,
            onDateChanged: (s) {
              bloc.startDateChanged(s);
              setState(() {});
            },
            date: snapshot.data,
          );
        });
  }

  _endDate() {
//    StepChooseDatePage.endDate = _endDate();
    var endDate = bloc.trip.startDate;
    return StreamBuilder<DateTime>(
        stream: bloc.endtDateStream,
        initialData: DateTime.now(),
        builder: (context, snapshot) {
          print(snapshot.data);

          return DatePicker(
            title: MadarLocalizations.of(context).trans('end_date'),
            withTimePicker: toAirport,
            onDateChanged: (e) {
              bloc.endDateChanged(e);
              setState(() {});
            },
            date: snapshot.data,
            endOfDay: true,
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
