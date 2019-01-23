import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/city_radio_tile.dart';
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

class ChooseCityStepState extends State<ChooseCityStep> with TickerProviderStateMixin {
  ChooseCityBloc bloc;
  TripPlaningBloc planingBloc;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseCityBloc(BlocProvider.of<AppBloc>(context).token);
    bloc.pushLocations;

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
                'What city are you planing to visit?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
            StreamBuilder<List<Location>>(
                stream: bloc.locationsStream,
                builder: (context, locationsSnapshot) {
                  if (locationsSnapshot.hasData && planingBloc.isLocationIdNull)
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
                              height: MediaQuery.of(context).size.height - 270,
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
                                  initialData: locationsSnapshot.data[0],
                                  builder: (context, snapshot) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.nameEn,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 16.0),
                                          child: Text(
                                            snapshot.data.descriptionEn,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                  : _titleShimmer(),
                            ),
                            locationsSnapshot.hasData
                                ? Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 3),
                              height: MediaQuery.of(context).size.width / 2,
                              child: StreamBuilder<int>(
                                stream: bloc.indexStream,
                                initialData: 0,
                                builder: (context, snapshot) {
                                  return ListView.builder(
                                    padding: EdgeInsets.only(
                                        right: 32,
                                        left: 32,
                                        top: 16,
                                        bottom: 16),
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
                            )
                                : _tilesShimmer(),
                          ],
                        ),
                      );
                    }
                  );
                }),
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
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3),
      height: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        padding: EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
        itemCount: 3,
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

  @override
  void dispose() {
    bloc.dispose();
    _controller.dispose();
    super.dispose();
  }
}
