import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/TripModel.dart';
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
  bool showFeedback;
  bool isPredefinedTrip;

  TripPlaningBloc(String token, String userId, {TripModel tripModel}) {
    isPredefinedTrip = false;
    if (tripModel == null)
      trip = Trip.init();
    else {
      isPredefinedTrip = true;
      trip = Trip.init();
      trip.inCity = true;
      trip.location = tripModel.location;
      trip.location.subLocationsIds = tripModel.predefinedTripsSublocations
          .map((s) => s.sublocationId)
          .toList();
      trip.endDate = trip.endDate.add(Duration(days: tripModel.duration));
    }
    index = 0;
    done = false;
    this.token = token;
    this.userId = userId;
    showFeedback = false;
  }

  final _navigationController = BehaviorSubject<int>();
  final _tripController = BehaviorSubject<Trip>();
  final _estimationCostController = BehaviorSubject<int>();
  final _mainButtonTextController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>();
  final _feedbackController = PublishSubject<String>();
  final _helpController = PublishSubject<bool>();

  get navigationStream => _navigationController.stream;

  get tripController => _tripController.stream;

  get estimationStream => _estimationCostController.stream;

  get changeTextStream => _mainButtonTextController.stream;

  get loadingStream => _loadingController.stream;

  get feedbackStream => _feedbackController.stream;

  get helpStream => _helpController.stream;

  changeButtonText(String text) => _mainButtonTextController.sink.add(text);

  pushLoading(bool load) => _loadingController.sink.add(load);

  get navBackward {
    if (!trip.inCity) {
      if (index == 5) index = 3;
      if (index == 4) index = 2;
      _navigationController.sink.add(--index);
    } else {
      _navigationController.sink.add(--index);
    }
    if (index == 0 || index == 1 || index == 2) {
      done = false;
      pushLoading(false);
      changeButtonText('next');
    }
  }

  get navForward {
    if (_shouldNav()) {
      if (index == 5) {
        _navigationController.sink.add(index);
      } else {
        _navigationController.sink.add(++index);
      }
      done = false;
      if (index == 4) {
        done = true;
      }
      if (trip.inCity) {
        if (index == 4) {
          pushLoading(true);
          changeButtonText('done');
        }
      } else {
        if (index == 3) {
          changeButtonText('done');
          pushLoading(true);
          done = true;
          index = 4;
        }
      }
    } else {}
    if (index == 0 || index == 1 || index == 2) {
      done = false;
      pushLoading(false);
      changeButtonText('next');
    }
  }

  _shouldNav() {
    if (index == 0) {
      if (trip.location != null) {
        return true;
      }
      return false;
    } else if (index == 1) {
      if (!trip.toAirport && !trip.fromAirport && !trip.inCity) {
        showFeedback = true;
        _feedbackController.sink.addError('error_fill_missing');
        return false;
      }
      return true;
    } else if (trip.endDate.isBefore(trip.startDate)) {
      showFeedback = true;
      _feedbackController.sink.addError('error_end_date_before_start_date');
      return false;
    } else if (index == 3) {
      if (trip.car != null) {
        return true;
      } else {
        showFeedback = true;
        _feedbackController.sink.addError('error_fill_missing');
      }
      return false;
    } else {
      return true;
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

  startDateChanged(DateTime startDate) {
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

  get pushEstimationCost => _estimationCostController.sink
      .add(trip.estimationPrice(withSubLocationPrice: true));

  //TODO: change!
  get isToAirport => trip.toAirport;

  get isFromAirport => trip.fromAirport;

  get isCityTour => trip.inCity;

  bool get isLocationIdNull => trip.location == null;

  submitTrip() {
    showFeedback = true;
    postTrip(trip, token, userId).then((d) {
      _loadingController.sink.add(false);
      _feedbackController.sink.add(d);
      navForward;
    }).catchError((e) {
      _loadingController.sink.add(false);
      Future.delayed(Duration(milliseconds: 10)).then((s) {
        if ((index == 3 && !trip.inCity) || index == 4)
          _loadingController.sink.add(true);
      });
      _feedbackController.addError(e.toString());
    });
  }

  submitHelp() {
    sendHelp(token).then((_) {
      _helpController.sink.add(true);
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
    _loadingController.close();
    _feedbackController.close();
    _helpController.close();
  }
}
