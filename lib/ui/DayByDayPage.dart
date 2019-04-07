import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/trip_planning/bloc/choose_sub_city_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/step_choose_city.dart';
import 'package:madar_booking/ui/DayByDaySubCityTile.dart';

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

//  List<SubLocationResponse> subList = [];
  DateTime cityDate ;
  DateTime cityEndDate ;
  DateTime date;
  DateTime startMore;
  DateTime _endDate;
  DateTime ss;
  List<int> _counter =new List();

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
    final CurvedAnimation curvedAnimation2 = CurvedAnimation(
        parent: _subCitiesController, curve: ElasticOutCurve(0.5));

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
    date = (planingBloc.trip.startDate);



    if(ChooseCityStep.subLocation != null){
      print("aa is : "+ChooseCityStep.name );

      for(int i = 0; i < planingBloc.trip.car.carSublocations.length ; i++ ){
        if(planingBloc.trip.car.carSublocations[i].subLocation.id  == ChooseCityStep.subLocation[0].id){
          print("cost is :"+planingBloc.trip.car.carSublocations[i].cost.toString() );
          planingBloc.addSubLocations(ChooseCityStep.subLocation[0].id , 1 , planingBloc.trip.car.carSublocations[i].cost , ChooseCityStep.name ,0);}
      }
    }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    var estimCost = planingBloc.trip.estimationPrice();
    final _itemExtent = 56.0;
    final generatedList = List.generate(10, (index) => 'Item $index');

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        StreamBuilder<int>(
                                            stream:
                                                planingBloc.estimationStream,
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

                                Container(
                                  height: MediaQuery.of(context).size.height/2.5,
                                  child: CustomScrollView(
                                    slivers: <Widget>[
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            if (planingBloc.trip.fromAirport ==
                                                true) {
                                              return Container(
                                                child: new Row(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            new Text((date)
                                                                .toString()
                                                                .split(" ")[0]
                                                                .replaceAll(
                                                                    "-", "/")),

//                                                new Text((date.add(new Duration(days:_counter ))  ).toString()):Text("")
//                                                  new Text(_endDate
//                                                      .toString()
//                                                      .split(" ")[0]
//                                                      .replaceAll("-", "/"))
                                                          ],
                                                        ),
                                                        citiesDashedLine()
                                                      ],
                                                    ),

//                                            SizedBox(
//                                              width: 40,
//                                            ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          new Text(
                                                            planingBloc
                                                                .trip.airport
                                                                .name(MadarLocalizations.of(
                                                                        context)
                                                                    .locale),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
//                                                Text(((planingBloc.trip
//                                                    .tripCost())
//                                                    .toString()))
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: <Widget>[
//                InkWell(
//                onTap: () {
//                setState(() {
//                if (!planingBloc.trip
//                    .isMaxDuration()) {
//                _counter++;
//                planingBloc
//                    .editSubLocation(
//                _counter,
//                index);
//                planingBloc
//                    .pushEstimationCost;
//                }
//                });
//                },
//                child:
//                                              new Icon(
//                                                Icons.arrow_drop_up,
//                                                size: 40,
//                                              )
//// ),
//                                              , new Text(
//                                                planingBloc.trip
//                                                    .tripDuration()
//                                                    .toString(),
//                                                style: TextStyle(
//                                                    color: Colors.black87,
//                                                    fontSize: 18,
//                                                    height: 0.5,
//                                                    fontWeight:
//                                                    FontWeight.w600),
//                                              ),
//                InkWell(
//                onTap: () {
//                setState(() {
//                if (_counter > 1) {
//                _counter--;
//                planingBloc
//                    .editSubLocation(
//                _counter,
//                index);
//                planingBloc
//                    .pushEstimationCost;
//                }
//                });
//                },
//                child:
//                                              new Icon(
//                                                Icons.arrow_drop_down,
//                                                size: 40,
//                                              )
// )
                                                      ],
                                                    ),
//                                          new Text("days")
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                          childCount: 1,
                                        ),
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            cityEndDate = date.add(new Duration(days:   planingBloc.trip
                                                .tripDuration())) ;

                                            return Container(
                                              child: new Row(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          new Text((date)
                                                              .toString()
                                                              .split(" ")[0]
                                                              .replaceAll(
                                                                  "-", "/")),

//                                                new Text((date.add(new Duration(days:_counter ))  ).toString()):Text("")
                                                          new Text(cityEndDate
                                                              .toString()
                                                              .split(" ")[0]
                                                              .replaceAll(
                                                                  "-", "/"))
                                                        ],
                                                      ),
                                                      citiesDashedLine()
                                                    ],
                                                  ),

//                                            SizedBox(
//                                              width: 40,
//                                            ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        new Text(
                                                          planingBloc
                                                              .trip.location
                                                              .name(MadarLocalizations
                                                                      .of(context)
                                                                  .locale),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),


                                                        Row(
                                                          children: <Widget>[
                                                            Text(planingBloc.trip
                                                                .tripDuration()
                                                                .toString()),

                                                            Text("*"),

                                                            Text(planingBloc.trip
                                                                   .car.pricePerDay.toString()),
                                                            Text("  "),
                                                            Text((planingBloc.trip
                                                                .car.pricePerDay *  planingBloc.trip
                                                                .tripDuration()).toString()  , style: TextStyle(fontWeight: FontWeight.bold),),Text( "\$",style: TextStyle(fontWeight: FontWeight.bold),)
                                                          ],
                                                        )
                                                            ,
                                                                  ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
//                InkWell(
//                onTap: () {
//                setState(() {
//                if (!planingBloc.trip
//                    .isMaxDuration()) {
//                _counter++;
//                planingBloc
//                    .editSubLocation(
//                _counter,
//                index);
//                planingBloc
//                    .pushEstimationCost;
//                }
//                });
//                },
//                child:
//                                                      new Icon(
//                                                        Icons.arrow_drop_up,
//                                                        size: 40,
//                                                      )
// ),
//                                                          ,
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:15.0, right: 15),
                                                        child: new Text(
                                                          planingBloc.trip
                                                              .tripDuration()
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black87,
                                                              fontSize: 18,
                                                              height: 0.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
//                InkWell(
//                onTap: () {
//                setState(() {
//                if (_counter > 1) {
//                _counter--;
//                planingBloc
//                    .editSubLocation(
//                _counter,
//                index);
//                planingBloc
//                    .pushEstimationCost;
//                }
//                });
//                },
//                child:
//                                                      new Icon(
//                                                        Icons.arrow_drop_down,
//                                                        size: 40,
//                                                      )
// )
                                                    ],
                                                  ),
                                                  Text(
                                                    MadarLocalizations.of(
                                                        context)
                                                        .trans(
                                                        'day'),
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          childCount: 1,
                                        ),
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            print("here is i'" +
                                                planingBloc
                                                    .trip
                                                    .tripSubLocations[index]
                                                    .id);

                                            _counter.insert(index, ( planingBloc.trip
                                                .getSubLocationDurationByNewId(
                                                planingBloc
                                                    .trip
                                                    .tripSubLocations[index]
                                                    .id ,index)));


                                            if (index == 0) {

                                              _endDate = cityEndDate.add(
                                                  new Duration(days: _counter[index]));
//                                              print("end is" +
//                                                  _endDate.toString());
//                                              print("start more : " +
//                                                  startMore.toString());
                                            } else {
//                                              print("end is" +
//                                                  _endDate.toString());

                                            if(_counter[index -1] == 0)
                                             { startMore = _endDate
                                                  ;}
                                            else
                                             { startMore = _endDate
                                                  .add(new Duration(days: 1));}


                                              ss = startMore.add(
                                                  new Duration(days: _counter[index]));
                                              _endDate = ss;
//                                              print("start more : " +
//                                                  startMore.toString());
                                            }

                                            return new Row(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        index == 0
                                                            ? new Text(planingBloc.trip
                                                            .tripDuration() != 0 ?(cityEndDate.add(new Duration(days: 1)))
                                                                .toString()
                                                                .split(" ")[0]
                                                                .replaceAll(
                                                                    "-", "/"):(date)
                                                            .toString()
                                                            .split(" ")[0]
                                                            .replaceAll(
                                                            "-", "/") )
                                                            : Text(startMore
                                                                .toString()
                                                                .split(" ")[0]
                                                                .replaceAll(
                                                                    "-", "/")),
                                                        index == 0
                                                            ?
//                                                new Text((date.add(new Duration(days:_counter ))  ).toString()):Text("")
                                                            new Text(_endDate
                                                                .toString()
                                                                .split(" ")[0]
                                                                .replaceAll(
                                                                    "-", "/"))
                                                            : Text(ss
                                                                .toString()
                                                                .split(" ")[0]
                                                                .replaceAll(
                                                                    "-", "/"))
                                                      ],
                                                    ),
                                                    citiesDashedLine()
                                                  ],
                                                ),

//                                            SizedBox(
//                                              width: 40,
//                                            ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      new Text(
                                                        planingBloc
                                                            .trip
                                                            .tripSubLocations[
                                                                index]
                                                            .subLocation
                                                            .nameTr,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      Row(
                                                        children: <Widget>[

                                                          Text(_counter[index]
                                                              .toString()),
                                                          Text("*"),


                                                          Text( (

                                                                  (planingBloc
                                                                          .trip
                                                                          .tripSubLocations[
                                                                              index]
                                                                          .cost)
                                                                      .toString())

                                                              ),
                                                          Text("  "),
                                                          Text(((_counter[index]) *
                                                              planingBloc
                                                                  .trip

                                                                  .tripSubLocations[
                                                              index]
                                                                  .cost)
                                                              .toString() ,style: TextStyle(fontWeight: FontWeight.bold),),Text( "\$",style: TextStyle(fontWeight: FontWeight.bold) )],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (!planingBloc
                                                                .trip
                                                                .isMaxDuration()) {
                                                            _counter[index]++;
                                                              planingBloc
                                                                  .editSubLocation(
                                                                      _counter[index],
                                                                      index);
                                                              planingBloc
                                                                  .pushEstimationCost;
                                                            }
                                                          });
                                                        },
                                                        child: new Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 40,
                                                        )),
                                                    new Text(
                                                      _counter[index].toString(),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          height: 0.5,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (_counter[index] > 0) {
                                                              _counter[index]--;
                                                              planingBloc
                                                                  .editSubLocation(
                                                                      _counter[index],
                                                                      index);
                                                              planingBloc
                                                                  .pushEstimationCost;
                                                            }
                                                          });
                                                        },
                                                        child: new Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 40,
                                                        ))
                                                  ],
                                                ),
                                                 Text(
                                                  MadarLocalizations.of(
                                                      context)
                                                      .trans(
                                                      'day'),
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ],
                                            );
                                          },
                                          childCount: planingBloc
                                              .trip.tripSubLocations.length,
                                        ),
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            if (planingBloc.trip.toAirport ==
                                                true) {
                                              return Container(
                                                child: new Row(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            new Text( _endDate != null ? (_endDate.add(
                                                                    new Duration(
                                                                        days:
                                                                            1)))
                                                                .toString()
                                                                .split(" ")[0]
                                                                .replaceAll(
                                                                    "-", "/"):cityEndDate.add(new Duration(
                                                                days:
                                                                1)).toString().split(" ")[0]
                                                                .replaceAll(
                                                                "-", "/")) ,

//                                                new Text((date.add(new Duration(days:_counter ))  ).toString()):Text("")
//                                                  new Text(_endDate
//                                                      .toString()
//                                                      .split(" ")[0]
//                                                      .replaceAll("-", "/"))
                                                          ],
                                                        ),
                                                        citiesDashedLine()
                                                      ],
                                                    ),

//                                            SizedBox(
//                                              width: 40,
//                                            ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          new Text(
                                                            planingBloc
                                                                .trip.airport
                                                                .name(MadarLocalizations.of(
                                                                        context)
                                                                    .locale),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
//                                                Text(((planingBloc.trip
//                                                    .tripCost())
//                                                    .toString()))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                          childCount: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

//                                Container(
//                                  height: 200,
//                                  child: ListView(
//                                    physics: ClampingScrollPhysics(),
//                                    shrinkWrap: true,
//                                    children: <Widget>[
//                                      Column(
//                                        children: <Widget>[
////                                          Container(
////                                            height: (planingBloc
////                                                        .trip
////                                                        .tripSubLocations
////                                                        .length *
////                                                    100)
////                                                .toDouble(),
////                                            child: ListView.builder(
////                                                itemCount: planingBloc.trip
////                                                    .tripSubLocations.length,
////                                                itemBuilder:
////                                                    (context, int index) {
//////                                    return  dayByDaySubCityList(subList[index] ,planingBloc.addSubLocation) ;
////
////                                                }),
////                                          ),
//                                        ],
//                                      ),
//                                    ],
//                                  ),
//                                ),

//                            subList.length != 0 ?
//                            dayByDaySubCityList(subList[0] ,planingBloc.addSubLocation): Container(),

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
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            AnimatedBuilder(
                                animation: _subCitiesFloat,
                                builder: (context, widget) {
                                  return Transform.translate(
                                    offset: _subCitiesFloat.value,
                                    child: StreamBuilder<
                                        List<SubLocationResponse>>(
                                      stream: bloc.subLocationsStream,
                                      // initialData: [],
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40.0, right: 40),
                                                child: Row(
                                                  children: <Widget>[
                                                    new Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans(
                                                              'Want_to_visit_other_cities_too'),
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 40),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                      height: 120,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: snapshot
                                                              .data.length,
                                                          itemBuilder: (context,
                                                              int index) {
                                                            return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    print(snapshot
                                                                        .data[
                                                                            index]
                                                                        .subLocation
                                                                        .nameEn);

                                                                    if (!planingBloc
                                                                        .trip
                                                                        .isMaxDuration()) {
                                                                      //String id, int duration, int cost, String subName, int idx
//                                                                      subList.add(
//                                                                          snapshot
//                                                                              .data[index]);
                                                                      planingBloc.addSubLocations(
                                                                          snapshot
                                                                              .data[
                                                                                  index]
                                                                              .subLocationId,
                                                                          1,
                                                                          snapshot
                                                                              .data[
                                                                                  index]
                                                                              .cost,
                                                                          snapshot
                                                                              .data[index]
                                                                              .subLocation
                                                                              .name(MadarLocalizations.of(context).locale),
                                                                          0);
                                                                      planingBloc
                                                                          .pushEstimationCost;
                                                                    } else
                                                                      print(
                                                                          "here i am");
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 4.0,
                                                                      right: 4),
                                                                  child: Wrap(
                                                                      spacing:
                                                                          16,
                                                                      runSpacing:
                                                                          16,
                                                                      children: <Widget>[
                                                                        DayByDaySubCityTile(
                                                                            subLocationResponse:
                                                                                snapshot.data[index])
                                                                      ]),
                                                                ));
                                                          }),

//                                                      child: ListView.builder(
//                                                        scrollDirection:
//                                                            Axis.horizontal,
//                                                        itemCount: 1,
//                                                        itemBuilder:
//                                                            (BuildContext
//                                                                    context,
//                                                                index) {
//                                                          return Wrap(
//                                                              crossAxisAlignment:
//                                                                  WrapCrossAlignment
//                                                                      .start,
//                                                              spacing: 16,
//                                                              runSpacing: 16,
//                                                              children: snapshot
//                                                                  .data
//                                                                  .map((subLocationResponse) =>
//                                                                      DayByDaySubCityTile(
////                                                        onCounterChanged:
////                                                            planingBloc
////                                                                .addSubLocation,
//                                                                        subLocationResponse:
//                                                                            subLocationResponse,
//                                                                      ))
//                                                                  .toList());
//                                                        },
//                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  );
                                }),
                          ],
                        ),
                      )
                    ],
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

Widget citiesDashedLine() {
//  return Container();
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.yellow.shade800,
            borderRadius: BorderRadius.circular(12.5),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 8.0),
        child: Container(
          height: 10,
          width: 2.0,
          color: Colors.yellow.shade800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 8.0),
        child: Container(
          height: 10,
          width: 2.0,
          color: Colors.yellow.shade800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 8.0),
        child: Container(
          height: 10,
          width: 2.0,
          color: Colors.yellow.shade800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 8.0),
        child: Container(
          height: 10,
          width: 2.0,
          color: Colors.yellow.shade800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 8.0),
        child: Container(
          height: 10,
          width: 2.0,
          color: Colors.yellow.shade800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 8.0),
        child: Container(
          height: 10,
          width: 2.0,
          color: Colors.yellow.shade800,
        ),
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );
}
