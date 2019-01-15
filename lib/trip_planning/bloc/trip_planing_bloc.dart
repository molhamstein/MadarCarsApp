import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:rxdart/rxdart.dart';

class TripPlaningBloc extends BaseBloc {

  Trip _trip;

  TripPlaningBloc() {
    _trip = Trip.init();
  }

  final _navigationController = BehaviorSubject<Widget>();
  final _tripController = BehaviorSubject<Trip>();


  get navigationStream => _navigationController.stream;
  get tripController => _tripController.stream;

  Function(bool) toAirport(to) { _trip.toAirport = to; }
  Function(bool) fromAirport(from) { _trip.fromAirport = from; }
  Function(bool) cityTour(cityTour) { _trip.inCity = cityTour; }


  //TODO: change!
  get isToAirport => _trip.toAirport;
  get isFromAirport => _trip.fromAirport;
  get isCityTour => _trip.inCity;



  @override
  void dispose() {
    _navigationController.close();
    _tripController.close();
  }

}