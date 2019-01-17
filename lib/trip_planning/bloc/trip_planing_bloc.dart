import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class TripPlaningBloc extends BaseBloc with Network {

  Trip trip;

  TripPlaningBloc() {
    trip = Trip.init();
  }

  final _navigationController = BehaviorSubject<Widget>();
  final _tripController = BehaviorSubject<Trip>();


  get navigationStream => _navigationController.stream;
  get tripController => _tripController.stream;

  toAirport(to) { trip.toAirport = to; }
  fromAirport(from) { trip.fromAirport = from; }
  cityTour(cityTour) { trip.inCity = cityTour; }
  startDateChanged(startDate) { trip.startDate = startDate; }
  endDateChanged(endDate) { trip.endDate = endDate; }
  cityId(Location location) { trip.location = location; }
  tripCar(Car car) { trip.car = car; }


  //TODO: change!
  get isToAirport => trip.toAirport;
  get isFromAirport => trip.fromAirport;
  get isCityTour => trip.inCity;


  bool get isLocationIdNull => trip.location == null;

  @override
  void dispose() {
    _navigationController.close();
    _tripController.close();
  }

}