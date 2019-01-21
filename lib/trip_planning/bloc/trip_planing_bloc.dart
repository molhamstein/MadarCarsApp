import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class TripPlaningBloc extends BaseBloc with Network {
  Trip trip;
  int index;
  bool done;
  String token;
  String userId;

  TripPlaningBloc(String token, String userId) {
    trip = Trip.init();
    index = 0;
    done = false;
    this.token = token;
    this.userId = userId;
  }

  final _navigationController = BehaviorSubject<int>();
  final _tripController = BehaviorSubject<Trip>();
  final _estimationCostController = BehaviorSubject<int>();
  final _mainButtonTextController = BehaviorSubject<String>();

  get navigationStream => _navigationController.stream;

  get tripController => _tripController.stream;

  get estimationStream => _estimationCostController.stream;

  get navBackward => _navigationController.sink.add(--index);

  get changeTextStream => _mainButtonTextController.stream;

  changeButtonText(String text) => _mainButtonTextController.sink.add(text);

  get navForward {
    if(index == 5){
      _navigationController.sink.add(index);
    }
    else {
      _navigationController.sink.add(++index);
    }
    done = false;
    if(index == 5) done = true;
    if (trip.inCity) {
      if(index == 4) {
        changeButtonText('Done');
      }
    }
    else {
      if(index == 3) {
        changeButtonText('Done');
        index = 5;
      }
    }
  }

  toAirport(to) {
    trip.toAirport = to;
  }

  fromAirport(from) {
    trip.fromAirport = from;
  }

  cityTour(cityTour) {
    trip.inCity = cityTour;
  }

  startDateChanged(startDate) {
    trip.startDate = startDate;
  }

  endDateChanged(endDate) {
    trip.endDate = endDate;
  }

  cityId(Location location) {
    trip.location = location;
  }

  tripCar(Car car) {
    trip.car = car;
  }

  Function(String, int, int) get addSubLocation => trip.addSubLocation;

  get pushEstimationCost =>
      _estimationCostController.sink.add(trip.estimationPrice());

  //TODO: change!
  get isToAirport => trip.toAirport;

  get isFromAirport => trip.fromAirport;

  get isCityTour => trip.inCity;

  bool get isLocationIdNull => trip.location == null;


  submitTrip() {
    postTrip(trip, token, userId).then((d) {
      print(d);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _navigationController.close();
    _tripController.close();
    _estimationCostController.close();
    _mainButtonTextController.close();
  }
}
