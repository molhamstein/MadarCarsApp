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

  TripPlaningBloc() {
    trip = Trip.init();
    index = 0;
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
    if (index == 2 && !trip.inCity) {
      _navigationController.sink.add(++index);
      changeButtonText('Done');
    } else if (index == 3) {
      changeButtonText('Done');
      _navigationController.sink.add(++index);
    }
    else{
      _navigationController.sink.add(++index);
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

  @override
  void dispose() {
    _navigationController.close();
    _tripController.close();
    _estimationCostController.close();
    _mainButtonTextController.close();
  }
}
