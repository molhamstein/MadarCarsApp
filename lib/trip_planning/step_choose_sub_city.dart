import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/trip_planning/bloc/choose_sub_city_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/widgets/sub_city_tile.dart';

class StepChooseSubCity extends StatefulWidget {
  @override
  StepChooseSubCityState createState() {
    return new StepChooseSubCityState();
  }
}

class StepChooseSubCityState extends State<StepChooseSubCity> {
  ChooseSubCityBloc bloc;
  TripPlaningBloc planingBloc;

  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseSubCityBloc(
        planingBloc.trip, BlocProvider.of<AppBloc>(context).token);
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
          Container(
            margin: EdgeInsets.only(right: 24, left: 24),
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 16, left: 16, top: 16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        MadarLocalizations.of(context).trans('estim_cost'),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        StreamBuilder<int>(
                            stream: planingBloc.estimationStream,
                            initialData: estimCost,
                            builder: (context, snapshot) {
                              print("estim Cost in stream ${snapshot.data}");
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 32, left: 32),
                  child: Text(
                    MadarLocalizations.of(context).trans('step_five_title'),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 0.8),
                  ),
                ),
                StreamBuilder<List<SubLocationResponse>>(
                  stream: bloc.subLocationsStream,
                  // initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: snapshot.data
                                        .map((subLocationResponse) =>
                                            SubCityTile(
                                              onCounterChanged:
                                                  planingBloc.addSubLocation,
                                              subLocationResponse:
                                                  subLocationResponse,
                                            ))
                                        .toList()),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
