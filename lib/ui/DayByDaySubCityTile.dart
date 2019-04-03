import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';

class DayByDaySubCityTile extends StatefulWidget {
  static String text = "";
  final SubLocationResponse subLocationResponse;
//  final Function(String, int, int, String) onCounterChanged;

  const DayByDaySubCityTile(
      {Key key,
        @required this.subLocationResponse,
//        @required this.onCounterChanged
      })
      : super(key: key);

  @override
  DayByDaySubCityTileState createState() {
    return new DayByDaySubCityTileState();
  }
}

class DayByDaySubCityTileState extends State<DayByDaySubCityTile> {
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
    final tileSize = MediaQuery.of(context).size.width / 2.8;
    return Container(
      height: tileSize,
      width: tileSize,
      decoration: BoxDecoration(
        gradient: MadarColors.gradiant_decoration,
        image: DecorationImage(
          image: NetworkImage(widget.subLocationResponse.subLocation.media.url),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.15), BlendMode.dstATop),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: tileSize,
            height: tileSize,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.subLocationResponse.subLocation
                        .name(MadarLocalizations.of(context).locale),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
//                Material(
//                  color: Colors.transparent,
//                  child: Row(
//                    mainAxisSize: MainAxisSize.max,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      InkWell(
//                        borderRadius: BorderRadius.circular(15),
//                        onTap: () {
//                          setState(() {
//                            if (_counter > 0) {
//                              _counter--;
//                              widget.onCounterChanged(
//                                  widget.subLocationResponse.subLocation.id,
//                                  _counter,
//                                  widget.subLocationResponse.cost,
//                                  widget.subLocationResponse.subLocation.name(
//                                      MadarLocalizations.of(context).locale));
//                              bloc.pushEstimationCost;
//                            }
//                          });
//                        },
//                        child: Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Icon(
//                            FontAwesomeIcons.minus,
//                            color: Colors.white,
//                            size: 16,
//                          ),
//                        ),
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Text(
//                            _counter.toString(),
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.w500,
//                              fontSize: 16,
//                            ),
//                          ),
//                          Padding(
//                            padding:
//                            const EdgeInsets.only(left: 4.0, bottom: 10),
//                            child: Text(
//                              MadarLocalizations.of(context).trans('days'),
//                              style:
//                              TextStyle(color: Colors.white, fontSize: 12),
//                            ),
//                          )
//                        ],
//                      ),
//                      InkWell(
//                        borderRadius: BorderRadius.circular(15),
//                        onTap: () {
//                          setState(
//                                () {
//                              if (!bloc.trip.isMaxDuration()) {
//                                _counter++;
//                                widget.onCounterChanged(
//                                    widget.subLocationResponse.subLocation.id,
//                                    _counter,
//                                    widget.subLocationResponse.cost,
//                                    widget.subLocationResponse.subLocation.name(
//                                        MadarLocalizations.of(context).locale));
//                                bloc.pushEstimationCost;
//                              }
//                            },
//                          );
//                        },
//                        child: Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Icon(
//                            FontAwesomeIcons.plus,
//                            color: Colors.white,
//                            size: 16,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 12),
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[800],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.subLocationResponse.cost.toString()} \$',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 0.7),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
