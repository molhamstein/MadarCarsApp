import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/car_card_widget_small.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/main.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/Language.dart';
import 'package:madar_booking/my_flutter_app_icons.dart';
import 'package:madar_booking/rate_widget.dart';
import 'package:madar_booking/trip_planning/bloc/choose_car_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/gallery.dart';
import 'package:madar_booking/widgets/language_tag.dart';
import 'package:shimmer/shimmer.dart';

class StepChooseCar extends StatefulWidget {
  @override
  StepChooseCarState createState() {
    return new StepChooseCarState();
  }
}

class StepChooseCarState extends State<StepChooseCar>
    with TickerProviderStateMixin {
  ChooseCarBloc bloc;
  TripPlaningBloc planingBloc;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  final productionDates = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022'
  ];
var shouldShowProgressBar ;
  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseCarBloc(
        planingBloc.trip, BlocProvider.of<AppBloc>(context).token);
    bloc.fetchGetAvailableCars();

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
shouldShowProgressBar = false  ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle infoLabelStyle = TextStyle(
        color: Colors.grey[700],
        fontSize: isScreenLongEnough ? 16 : 12,
        fontWeight: FontWeight.w700,
        height: 0.8);
    final double iconSize = 18;

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Car>>(
                stream: bloc.carsStream,
                builder: (context, carsSnapshot) {
                  if (carsSnapshot.hasData && carsSnapshot.data.isEmpty) {
                    bloc.trip.car = null;
                  }
                  if (carsSnapshot.hasData && carsSnapshot.data.isNotEmpty) {
                    if (bloc.trip.car != null) {
                      planingBloc.tripCar(bloc.trip.car);
                      bloc.selectCar(
                          bloc.trip.car,
                          carsSnapshot.data
                              .indexWhere((car) => car.id == bloc.trip.car.id));
                    } else {
                      bloc.selectCar(carsSnapshot.data[0], 0);
                      planingBloc.tripCar(carsSnapshot.data[0]);

                      ;
                    }
                  }
                  return AnimatedBuilder(
                    animation: _offsetFloat,
                    builder: (context, widget) {
                      return Transform.translate(
                        offset: _offsetFloat.value,
                        child: Stack(
                          children: <Widget>[
                            StreamBuilder<Car>(
                                stream: bloc.selectedCarStream,
                                builder: (context, carSnapshot) {
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 24, left: 24),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            right: 16, left: 16, top: 16),
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
                                        child: carsSnapshot.hasData &&
                                                carsSnapshot.data.isNotEmpty &&
                                                carSnapshot.hasData
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: Text(
                                                          MadarLocalizations.of(
                                                                  context)
                                                              .trans(
                                                                  'estim_cost'),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height: 0.5),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          Text(
                                                            planingBloc.trip
                                                                .estimationPrice()
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[800],
                                                                fontSize: 60,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 0.5),
                                                          ),
                                                          Text(
                                                            '\$',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[800],
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(8),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                carSnapshot
                                                                    .data
                                                                    .driver
                                                                    .media
                                                                    .url),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            carSnapshot
                                                                .data.name,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    isScreenLongEnough
                                                                        ? 20
                                                                        : 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey[800],
                                                                height: 0.5),
                                                          ),
                                                          Text(
                                                            carSnapshot
                                                                    .data
                                                                    .driver
                                                                    .firstName +
                                                                " " +
                                                                carSnapshot
                                                                    .data
                                                                    .driver
                                                                    .lastName,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    isScreenLongEnough
                                                                        ? 16
                                                                        : 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey[600],
                                                                height: 0.5),
                                                          ),
                                                        ],
                                                      ),
                                                      RateWidget(
                                                        carSnapshot.data.rate
                                                            .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 12,
                                                  ),
                                                  Wrap(
                                                    spacing: 4,
                                                    children:
                                                        carSnapshot.data.driver
                                                            .driverLangs
                                                            .map(
                                                                (language) =>
                                                                    LanguageTag(
                                                                      text:
                                                                          Text(
                                                                        language
                                                                            .language
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w700,
                                                                            height: 0.8),
                                                                      ),
                                                                    ))
                                                            .toList(),
                                                  ),
                                                  Container(
                                                    height: 16,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: _infoRow(
                                                        carSnapshot,
                                                        infoLabelStyle,
                                                        iconSize),
                                                  ),
                                                ],
                                              )
                                            : carsSnapshot.hasData &&
                                                    carsSnapshot.data.isEmpty
                                                ? _empty()
                                                : _topShimmer(),
                                      ),
                                      isScreenLongEnough
                                          ? carsSnapshot.hasData &&
                                                  carsSnapshot.data.isNotEmpty
                                              ? Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            11,
                                                    margin: EdgeInsets.only(
                                                        bottom: 60),
                                                    child:
                                                        carSnapshot.data != null
                                                            ? ListView.builder(
                                                                key:
                                                                    UniqueKey(),
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .push(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Gallery(
                                                                                  images: carSnapshot.data.carMedia,
                                                                                  initialIndex: index,
                                                                                ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.height /
                                                                            12,
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                12,
                                                                        margin:
                                                                            EdgeInsets.all(4),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(4),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                blurRadius: 4,
                                                                                color: Colors.black45)
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            Hero(
                                                                          tag: carSnapshot
                                                                              .data
                                                                              .carMedia[index]
                                                                              .id,
                                                                          child:
                                                                              FadeInImage(
                                                                            placeholder:
                                                                                AssetImage('assets/images/logo.png'),
                                                                            image:
                                                                                NetworkImage(carSnapshot.data.carMedia[index].url),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                itemCount:
                                                                    carSnapshot
                                                                        .data
                                                                        .carMedia
                                                                        .length,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                              )
                                                            : Container(),
                                                  ),
                                                )
                                              : Container()
                                          : Container(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 40.0),
                                              child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                     bloc.shouldShowProgressIndecator ? CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                    MadarColors.dark_grey,
                                                  )) : new Container()),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 100,
                                              margin: EdgeInsets.only(
                                                  right: 32, left: 32, top: 40),
                                              decoration: BoxDecoration(
                                                color: Colors.black87,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 15,
                                                  ),
                                                ],
                                              ),
                                              child: GestureDetector(
                                                onTap: () => showModal(context),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.filter_list,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      Text(
                                                        MadarLocalizations.of(
                                                                context)
                                                            .trans('filters'),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            carsSnapshot.hasData && carsSnapshot.data.isNotEmpty
                                ? StreamBuilder<int>(
                                    stream: bloc.indexStream,
                                    initialData: 0,
                                    builder: (context, indexSnapshot) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            top: isScreenLongEnough
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.8
                                                : MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2.3),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                        child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            return CarCardSmall(
                                              car: carsSnapshot.data[index],
                                              onTap: (car) {
                                                print('onTap');
                                                bloc.selectCar(car, index);
                                                planingBloc.tripCar(
                                                    carsSnapshot.data[index]);
                                              },
                                              selected:
                                                  index == indexSnapshot.data,
                                            );
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount: carsSnapshot.data.length,
                                        ),
                                      );
                                    })
                                : carsSnapshot.hasData &&
                                        carsSnapshot.data.isEmpty
                                    ? Container()
                                    : _listShimmer(),
                            StreamBuilder<bool>(
                                stream: planingBloc.showFiltersStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData && snapshot.data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showModal(context);
                                    });
                                  }
                                  return Container();
                                })
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  _topShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[100],
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
                      fontWeight: FontWeight.w700,
                      height: 0.5),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    height: 24,
                    width: 40,
                    color: Colors.grey[300],
                  ),
                  Container(
                    height: 18,
                    width: 80,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 14,
                width: 32,
                color: Colors.grey[300],
              ),
            ],
          ),
          Container(
            height: 30,
          ),
          Wrap(spacing: 4, children: [
            Container(
              height: 10,
              width: 40,
              color: Colors.grey[300],
            ),
            Container(
              height: 10,
              width: 40,
              color: Colors.grey[300],
            ),
            Container(
              height: 10,
              width: 40,
              color: Colors.grey[300],
            ),
          ]),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp.cal,
                      size: 28,
                      color: Colors.grey[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 12,
                        width: 40,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        MyFlutterApp.gender,
                        size: 28,
                        color: Colors.grey[800],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          height: 12,
                          width: 40,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp.seats,
                      size: 28,
                      color: Colors.grey[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 12,
                        width: 40,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _listShimmer() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.8),
      height: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
            child: Container(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 1.3,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[300],
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 2,
      ),
    );
  }

  Widget _empty() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            MadarLocalizations.of(context).trans('no_cars_error'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          FlatButton(
            onPressed: () => planingBloc.navBackward,
            child: Text(
              MadarLocalizations.of(context).trans('back'),
            ),
          ),
        ],
      ),
    );
  }

  _infoRow(carSnapshot, infoLabelStyle, iconSize) {
    if (isScreenLongEnough) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                MyFlutterApp.cal,
                size: iconSize,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(carSnapshot.data.productionDate.toString(),
                    style: infoLabelStyle),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                MyFlutterApp.gender,
                size: iconSize,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    MadarLocalizations.of(context)
                        .trans(carSnapshot.data.driver.gender),
                    style: infoLabelStyle),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                MyFlutterApp.seats,
                size: iconSize,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    '${carSnapshot.data.numOfSeat.toString()} ' +
                        MadarLocalizations.of(context).trans('seats'),
                    style: infoLabelStyle),
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                MyFlutterApp.cal,
                size: iconSize,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(carSnapshot.data.productionDate.toString(),
                    style: infoLabelStyle),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                MyFlutterApp.gender,
                size: iconSize,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    MadarLocalizations.of(context)
                        .trans(carSnapshot.data.driver.gender),
                    style: infoLabelStyle),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                MyFlutterApp.seats,
                size: iconSize,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    '${carSnapshot.data.numOfSeat.toString()} ' +
                        MadarLocalizations.of(context).trans('seats'),
                    style: infoLabelStyle),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (carSnapshot.data.carMedia.isNotEmpty)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Gallery(
                          images: carSnapshot.data.carMedia,
                          initialIndex: 0,
                        ),
                  ),
                );
            },
            child: Column(
              children: <Widget>[
                carSnapshot.data.carMedia.isNotEmpty
                    ? Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                    carSnapshot.data.carMedia[0].url),
                                fit: BoxFit.cover)),
                      )
                    : Icon(
                        Icons.not_interested,
                        color: Colors.grey,
                        size: 20,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      '${carSnapshot.data.carMedia != null ? carSnapshot.data.carMedia.length : 0} ' +
                          MadarLocalizations.of(context).trans('images'),
                      style: infoLabelStyle),
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  showModal(context) {
    final titleStyle = TextStyle(
      color: MadarColors.gradientDown,
      fontWeight: FontWeight.w700,
    );

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              planingBloc.hideModal;
              return true;
            },
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(right: 16, left: 16),
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        MadarLocalizations.of(context).trans('filters'),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      StreamBuilder<Type>(
                          stream: planingBloc.carTypeStream,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      MadarLocalizations.of(context)
                                          .trans('filter_vip_title'),
                                      style: titleStyle,
                                    ),
                                    snapshot.hasData &&
                                            snapshot.data != Type.none
                                        ? ActionChip(
                                            padding: EdgeInsets.all(1),
                                            label: Text(
                                              snapshot.data
                                                  .toString()
                                                  .split('.')
                                                  .last,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 0.8,
                                              ),
                                            ),
                                            onPressed: () {
                                              planingBloc
                                                  .selectCarType(Type.none);
                                            },
                                            avatar: Icon(
                                              Icons.close,
                                              size: 18,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16, bottom: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SquareFilterButton(
                                        child: Text(
                                          MadarLocalizations.of(context)
                                              .trans('vip_cars'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              height: 0.8),
                                        ),
                                        selected: snapshot.data == Type.vip,
                                        onTap: () {
                                          planingBloc.selectCarType(Type.vip);
                                        },
                                      ),
                                      Container(
                                        width: 8,
                                      ),
                                      SquareFilterButton(
                                        child: Text(
                                          MadarLocalizations.of(context)
                                              .trans('all_cars'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              height: 0.8),
                                        ),
                                        selected: snapshot.data == Type.normal,
                                        onTap: () {
                                          planingBloc
                                              .selectCarType(Type.normal);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      Divider(),
                      StreamBuilder<String>(
                          stream: planingBloc.productionDateStream,
                          builder: (context, snapshot) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      MadarLocalizations.of(context)
                                          .trans('filter_car_model_year_title'),
                                      style: titleStyle,
                                    ),
                                    snapshot.hasData && snapshot.data != null
                                        ? ActionChip(
                                            padding: EdgeInsets.all(1),
                                            label: Text(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 0.8,
                                              ),
                                            ),
                                            onPressed: () {
                                              planingBloc.clearProductionDate();
                                            },
                                            avatar: Icon(
                                              Icons.close,
                                              size: 18,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: productionDates.map((s) {
                                    return DropdownMenuItem<String>(
                                      child: Container(
                                          color: Colors.white,
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width /
                                          //     1.5,
                                          constraints: BoxConstraints.expand(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(s),
                                          )),
                                      value: s,
                                    );
                                  }).toList(),
                                  onChanged: planingBloc.selectProductionDate,
                                  value:
                                      snapshot.hasData ? snapshot.data : null,
                                  hint: Text(
                                    MadarLocalizations.of(context)
                                        .trans('car_model_year'),
                                  ),
                                ),
                              ],
                            );
                          }),
                      Divider(),
                      StreamBuilder<int>(
                          stream: planingBloc.numberOfSeatsStream,
                          initialData: 1,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      MadarLocalizations.of(context)
                                          .trans('number_of_seats'),
                                      style: titleStyle,
                                    ),
                                    snapshot.hasData && snapshot.data >= 2
                                        ? ActionChip(
                                            padding: EdgeInsets.all(1),
                                            label: Text(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 0.8,
                                              ),
                                            ),
                                            onPressed: () {
                                              planingBloc.clearNumberOfSeats();
                                            },
                                            avatar: Icon(
                                              Icons.close,
                                              size: 18,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: EdgeInsets.only(top: 16, bottom: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RoundFilterButton(
                                        child: Icon(
                                          FontAwesomeIcons.plus,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        onTap: () {
                                          planingBloc.plusSeat();
                                        },
                                      ),
                                      Text(
                                        snapshot.data < 2
                                            ? '-'
                                            : snapshot.data.toString(),
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      RoundFilterButton(
                                        child: Icon(
                                          FontAwesomeIcons.minus,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        onTap: () {
                                          planingBloc.minusSeat();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      Divider(),
                      StreamBuilder<Gender>(
                          stream: planingBloc.genderStream,
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  MadarLocalizations.of(context)
                                      .trans('driver_gender'),
                                  style: titleStyle,
                                ),
                                snapshot.hasData && snapshot.data != Gender.none
                                    ? ActionChip(
                                        padding: EdgeInsets.all(1),
                                        label: Text(
                                          MadarLocalizations.of(context).trans(
                                              snapshot.data
                                                  .toString()
                                                  .split('.')
                                                  .last),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8,
                                          ),
                                        ),
                                        onPressed: () {
                                          planingBloc.selectGender(Gender.none);
                                        },
                                        avatar: Icon(
                                          Icons.close,
                                          size: 18,
                                        ),
                                      )
                                    : Container(),
                              ],
                            );
                          }),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: StreamBuilder<Object>(
                            stream: planingBloc.genderStream,
                            builder: (context, snapshot) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GenderFilterButton(
                                    child: Icon(
                                      FontAwesomeIcons.male,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    padding: 16,
                                    selected: snapshot.data == Gender.male,
                                    onTap: () {
                                      planingBloc.selectGender(Gender.male);
                                    },
                                  ),
                                  GenderFilterButton(
                                    child: Icon(
                                      FontAwesomeIcons.female,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    padding: 16,
                                    selected: snapshot.data == Gender.female,
                                    onTap: () {
                                      planingBloc.selectGender(Gender.female);
                                    },
                                  ),
                                ],
                              );
                            }),
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text(
                            MadarLocalizations.of(context)
                                .trans('driver_language'),
                            style: titleStyle,
                          ),
                        ],
                      ),
                      StreamBuilder<List<Language>>(
                          stream: planingBloc.languagesStream,
                          builder: (context, snapshot) {
                            return StreamBuilder<List<String>>(
                                stream: planingBloc.languagesIdsStream,
                                builder: (context, snapshot2) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    child: Row(
                                      children: snapshot.hasData
                                          ? snapshot.data
                                              .map((language) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: ChoiceChip(
                                                      label: Text(
                                                        language.name,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      onSelected: (selected) {
                                                        setState(() {
                                                          if (selected)
                                                            planingBloc
                                                                .selectLanguage(
                                                                    language
                                                                        .id);
                                                          else
                                                            planingBloc
                                                                .removeLanguage(
                                                                    language
                                                                        .id);
                                                        });
                                                      },
                                                      selectedColor:
                                                          Colors.black87,
                                                      selected: snapshot2.data
                                                          .contains(
                                                              language.id),
                                                    ),
                                                  ))
                                              .toList()
                                          : [Container()],
                                    ),
                                  );
                                });
                          }),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 16,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
//                              shouldShowProgressBar = false;
                              Navigator.of(context).pop();

                            setState(() {
                              bloc.shouldShowProgressIndecator = true;

                            });


                              bloc.trip.car = null;
                              bloc.fetchGetAvailableCars(
                                langIds: planingBloc.langFiltersIds,
                                numberOfSeats: planingBloc.numberOfSeats > 1
                                    ? planingBloc.numberOfSeats
                                    : null,
                                gender: planingBloc.gender,
                                type: planingBloc.type,
                                productionDate: planingBloc.productionDate,
                              );

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                  child: Text(
                                MadarLocalizations.of(context).trans('apply'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    height: 0.8),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class RoundFilterButton extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final double padding;

  const RoundFilterButton({Key key, this.child, this.onTap, this.padding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 16,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class GenderFilterButton extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double padding;
  final bool selected;

  const GenderFilterButton(
      {Key key,
      this.child,
      this.onTap,
      this.padding = 10,
      this.selected = false})
      : super(key: key);

  @override
  _GenderFilterButtonState createState() => _GenderFilterButtonState();
}

class _GenderFilterButtonState extends State<GenderFilterButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.onTap != null) {
            widget.onTap();
          }
        });
      },
      child: widget.selected
          ? Container(
              padding: EdgeInsets.all(widget.padding),
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 16,
                  ),
                ],
              ),
              child: widget.child,
            )
          : Container(
              padding: EdgeInsets.all(widget.padding),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: widget.child,
            ),
    );
  }
}

class SquareFilterButton extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final double padding;
  final bool selected;

  const SquareFilterButton(
      {Key key,
      this.child,
      this.onTap,
      this.padding = 10,
      this.selected = false})
      : super(key: key);

  @override
  _SquareFilterButtonState createState() => _SquareFilterButtonState();
}

class _SquareFilterButtonState extends State<SquareFilterButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            if (widget.onTap != null) widget.onTap();
          });
        },
        child: widget.selected
            ? Container(
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: widget.child,
              )
            : Container(
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.child,
              ),
      ),
    );
  }
}
