import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/trip_planning/bloc/choose_sub_city_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/ui/DayByDaySubCityTile.dart';
import 'package:madar_booking/widgets/sub_city_tile.dart';
import 'package:shimmer/shimmer.dart';

class DayByDayPage extends StatefulWidget {
  @override
  DayByDayPageState createState() {
    return new DayByDayPageState();
  }
}

class DayByDayPageState extends State<DayByDayPage>
    with TickerProviderStateMixin {
  ChooseSubCityBloc bloc;
  TripPlaningBloc planingBloc;
  AnimationController _controller;
  AnimationController _subCitiesController;

  Animation<Offset> _offsetFloat;
  Animation<Offset> _subCitiesFloat;


  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseSubCityBloc(
        planingBloc.trip, BlocProvider.of<AppBloc>(context).token);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _subCitiesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(0.5));

    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 200), end: Offset.zero)
        .animate(curvedAnimation);

    _offsetFloat.addListener(() {
      setState(() {});
    });
    final CurvedAnimation curvedAnimation2 =
    CurvedAnimation(parent: _subCitiesController, curve: ElasticOutCurve(0.5));


    _subCitiesFloat = Tween<Offset>(begin: Offset(700, 0), end: Offset.zero)
        .animate(curvedAnimation2);
    _subCitiesFloat.addListener(() {
      setState(() {});
    });


    _controller.forward();

    Future.delayed(Duration(seconds: 1)).then((_) {
      _subCitiesController.forward();
    });

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
          AnimatedBuilder(
              animation: _offsetFloat,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _offsetFloat.value,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 24, left: 24),
                        height: MediaQuery.of(context).size.height - 120,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(right: 16, left: 16, top: 16),
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
                        child: Column(
                          children: <Widget>[
                            Column(
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
                                        MadarLocalizations.of(context)
                                            .trans('estim_cost'),
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
                                              print(
                                                  "estim Cost in stream ${snapshot.data}");
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

                                new Row(children: <Widget>[Column(children: <Widget>[new Text("12/12/2012"),new Text("12/12/2012")],),Column(children: <Widget>[new Text("Istanbul"),Text("5 * 100 -> 5\$")],),new Row(children: <Widget>[Column(children: <Widget>[new Icon(Icons.arrow_drop_up), new Row(children: <Widget>[new Text("5") , new Text("days") ],),  new Icon(Icons.arrow_drop_down)],)],)],),


//                Padding(
//                  padding: const EdgeInsets.only(top: 30, right: 32, left: 32),
//                  child: Text(
//                    MadarLocalizations.of(context).trans('step_five_title'),
//                    style: TextStyle(
//                        color: Colors.grey[700],
//                        fontSize: 18,
//                        fontWeight: FontWeight.w600,
//                        height: 0.8),
//                  ),
//                ),

                              ],
                            ),
                          ],
                        ),
                      ),


                      Container(height: MediaQuery.of(context).size.height - 200,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,mainAxisSize: MainAxisSize.max,
                          children: <Widget>[


                            AnimatedBuilder(
                                animation: _subCitiesFloat,
                                builder: (context, widget) {
                                  return Transform.translate(
                                    offset: _subCitiesFloat.value,

                              child: StreamBuilder<List<SubLocationResponse>>(
                                stream: bloc.subLocationsStream,
                                // initialData: [],
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left:40.0 , right: 40),
                                          child: Row(
                                            children: <Widget>[
                                              new Text( MadarLocalizations.of(context)
                                                  .trans('Want_to_visit_other_cities_too'),style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 40),
                                          child: Row(
                                            children: <Widget>[
                                              Container(width: MediaQuery.of(context).size.width-40,
                                                height: 120,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (BuildContext context, index) {
                                                    print(index);
                                                    return Wrap(
                                                        crossAxisAlignment:
                                                        WrapCrossAlignment.start,
                                                        spacing: 16,
                                                        runSpacing: 16,
                                                        children: snapshot.data
                                                            .map((subLocationResponse) =>
                                                            DayByDaySubCityTile(
//                                                        onCounterChanged:
//                                                            planingBloc
//                                                                .addSubLocation,
                                                              subLocationResponse:
                                                              subLocationResponse,
                                                            ))
                                                            .toList());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else {
                                  return  Container();
                                  }
                                },
                              ),
                            );}),
                          ],
                        ),
                      ) ],
                  ),
                );
              }),
        ],
      ),
    );
  }

//  _tilesShimmer() {
//    return Container(
//      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
//      height: MediaQuery.of(context).size.width / 2,
//      child: ListView.builder(
//        padding: EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
//        itemCount: 1,
//        scrollDirection: Axis.horizontal,
//        itemBuilder: (context, index) {
//          return Shimmer.fromColors(
//            baseColor: Colors.grey[300],
//            highlightColor: Colors.grey[200],
//            child: Container(
//              margin: EdgeInsets.all(8),
//              width: MediaQuery.of(context).size.width / 2.5,
//              height: MediaQuery.of(context).size.width / 2.5,
//              color: Colors.grey[300],
//            ),
//          );
//        },
//      ),
//    );
//  }
}
