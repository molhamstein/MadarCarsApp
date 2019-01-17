import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/car_card_widget.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/rate_widget.dart';
import 'package:madar_booking/trip_planning/bloc/choose_car_bloc.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/widgets/language_tag.dart';

class StepChooseCar extends StatefulWidget {
  @override
  StepChooseCarState createState() {
    return new StepChooseCarState();
  }
}

class StepChooseCarState extends State<StepChooseCar> {
  ChooseCarBloc bloc;
  TripPlaningBloc planingBloc;

  @override
  void initState() {
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    bloc = ChooseCarBloc(planingBloc.trip, BlocProvider.of<AppBloc>(context).token);
    bloc.pushCars;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle infoLabelStyle = TextStyle(
        color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.w700);
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder<List<Car>>(
              stream: bloc.carsStream,
              builder: (context, carsSnapshot) {
                if(carsSnapshot.hasData) planingBloc.tripCar(carsSnapshot.data[0]);
                return Stack(
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
                      child: carsSnapshot.hasData
                          ? StreamBuilder<Car>(
                              stream: bloc.selectedCarStream,
                              initialData: carsSnapshot.data[0],
                              builder: (context, carSnapshot) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            'Estim Cost',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              '${planingBloc.trip.carEstimationPrice(carSnapshot.data.pricePerDay, carSnapshot.data.priceOneWay, carSnapshot.data.priceTowWay)}',
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 60,
                                                  fontWeight: FontWeight.w700),
                                            ),
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
                                      padding: EdgeInsets.all(20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              carSnapshot.data.name,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800]),
                                            ),
                                            Text(
                                              carSnapshot.data.driver.username,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                        RateWidget(
                                          rate:
                                              carSnapshot.data.rate.toString(),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 15,
                                    ),
                                    Wrap(
                                      spacing: 4,
                                      children:
                                          carSnapshot.data.driver.driverLangs
                                              .map((language) => LanguageTag(
                                                    text: Text(
                                                      language.language.name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ))
                                              .toList(),
                                    ),
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
                                                FontAwesomeIcons.calendar,
                                                size: 28,
                                                color: Colors.grey[800],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    carSnapshot
                                                        .data.productionDate.substring(0, 4),
                                                    style: infoLabelStyle),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.transgender,
                                                  size: 28,
                                                  color: Colors.grey[800],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                      carSnapshot
                                                          .data.driver.gender,
                                                      style: infoLabelStyle),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.chair,
                                                size: 28,
                                                color: Colors.grey[800],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    '${carSnapshot.data.numOfSeat.toString()} Seats',
                                                    style: infoLabelStyle),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              })
                          : CircularProgressIndicator(),
                    ),
                    carsSnapshot.hasData
                        ? StreamBuilder<int>(
                            stream: bloc.indexStream,
                            initialData: 0,
                            builder: (context, indexSnapshot) {
                              return Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.2),
                                height: MediaQuery.of(context).size.width / 2,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return CarCard(
                                      car: carsSnapshot.data[index],
                                      onTap: (car) {
                                        bloc.selectCar(car, index);
                                        planingBloc.tripCar(carsSnapshot.data[index]);
                                      },
                                      selected: index == indexSnapshot.data,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: carsSnapshot.data.length,
                                ),
                              );
                            })
                        : CircularProgressIndicator(),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
