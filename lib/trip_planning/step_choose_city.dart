import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/city_radio_tile.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/main.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/trip_planning/bloc/choose_city_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ChooseCityStep extends StatefulWidget {
  @override
  ChooseCityStepState createState() {
    return new ChooseCityStepState();
  }
}

class ChooseCityStepState extends State<ChooseCityStep>
    with TickerProviderStateMixin {
  ChooseCityBloc bloc;
  TripPlaningBloc planingBloc;
  AnimationController _mainController;
  AnimationController _citiesController;
  Animation<Offset> _offsetFloat;
  Animation<Offset> _citiesFloat;

  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseCityBloc(BlocProvider.of<AppBloc>(context).token);
    bloc.pushLocations;

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _citiesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _mainController, curve: ElasticOutCurve(0.5));
    final CurvedAnimation curvedAnimation2 =
        CurvedAnimation(parent: _citiesController, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, -4000), end: Offset.zero)
        .animate(curvedAnimation);
    _citiesFloat = Tween<Offset>(begin: Offset(500, 0), end: Offset.zero)
        .animate(curvedAnimation2);

    _offsetFloat.addListener(() {
      setState(() {});
    });

    _citiesFloat.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration(seconds: 1)).then((_) {
      _citiesController.forward();
    });

    _mainController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, left: 60, right: 60),
              child: Text(
                MadarLocalizations.of(context).trans('step_one_title'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Location>>(
                  stream: bloc.locationsStream,
                  builder: (context, locationsSnapshot) {
                    if (locationsSnapshot.hasData &&
                        (planingBloc.isLocationIdNull ||
                            planingBloc.trip.location.subLocationsIds == null))
                      planingBloc.cityId(locationsSnapshot
                          .data[0]); // initial location (pre selected)

                    return AnimatedBuilder(
                        animation: _offsetFloat,
                        builder: (context, widget) {
                          return Transform.translate(
                            offset: _offsetFloat.value,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.only(right: 24, left: 24),
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
                                  child: locationsSnapshot.hasData
                                      ? StreamBuilder<Location>(
                                          stream: bloc.selectedCitStream,
                                          initialData:
                                              planingBloc.trip.location != null
                                                  ? planingBloc.trip.location
                                                  : locationsSnapshot.data[0],
                                          builder: (context, snapshot) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data.name(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .locale),
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16.0),
                                                  child: Text(
                                                    snapshot.data.description(
                                                        MadarLocalizations.of(
                                                                context)
                                                            .locale),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: .8),
                                                  ),
                                                ),
                                              ],
                                            );
                                          })
                                      : _titleShimmer(),
                                ),
                                AnimatedBuilder(
                                  animation: _citiesFloat,
                                  builder: (context, widget) {
                                    return Transform.translate(
                                      offset: _citiesFloat.value,
                                      child: Container(
                                        child: locationsSnapshot.hasData
                                            ? _cities(locationsSnapshot)
                                            : _tilesShimmer(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _titleShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 22,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 16,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  _tilesShimmer() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      height: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        padding: EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
            child: Container(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.width / 2.5,
              color: Colors.grey[300],
            ),
          );
        },
      ),
    );
  }

  _cities(locationsSnapshot) {
    return Container(
      margin: EdgeInsets.only(
          top: isScreenLongEnough
              ? MediaQuery.of(context).size.height / 3.5
              : MediaQuery.of(context).size.height / 4),
      height: MediaQuery.of(context).size.width / 2,
      child: StreamBuilder<int>(
        stream: bloc.indexStream,
        initialData: 0,
        builder: (context, snapshot) {
          return ListView.builder(
            padding: EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
            itemCount: locationsSnapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CityRadioTile(
                location: locationsSnapshot.data[index],
                selected: index == snapshot.data,
                onTap: (location) {
                  bloc.selectLocation(location, index);
                  planingBloc.cityId(location);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    _mainController.dispose();
    super.dispose();
  }
}
