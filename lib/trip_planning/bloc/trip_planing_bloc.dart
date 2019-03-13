import 'dart:async';

import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/CheckCouponModel.dart';
import 'package:madar_booking/models/CouponModel.dart';
import 'package:madar_booking/models/Language.dart';
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
  int numberOfSeats;
  Gender gender;
  String productionDate;
  List<String> langFiltersIds;
  String couponid ;

  Type type;

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
          .map((s) => s.subLocationId)
          .toList();
      trip.endDate = trip.endDate.add(Duration(days: tripModel.duration));
    }
    index = 0;
    done = false;
    this.token = token;
    this.userId = userId;
    showFeedback = false;
    numberOfSeats = 1;
    langFiltersIds = [];
    _languagesIdsController.sink.add(langFiltersIds);
  }

  final _navigationController = BehaviorSubject<int>();
  final _tripController = BehaviorSubject<Trip>();
  final _estimationCostController = BehaviorSubject<int>();
  final _mainButtonTextController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>();
  final _feedbackController = PublishSubject<String>();
  final _helpController = PublishSubject<bool>();
  final _noteButtonController = PublishSubject<bool>();
  final _carTypeController = BehaviorSubject<Type>();
  final _genderController = BehaviorSubject<Gender>();
  final _productionDateController = BehaviorSubject<String>();
  final _numberOfSeatsController = ReplaySubject<int>();
  final _languagesController = ReplaySubject<List<Language>>();
  final _languagesIdsController = ReplaySubject<List<String>>();
  final _modalController = PublishSubject<bool>();

  get navigationStream => _navigationController.stream;

  get tripController => _tripController.stream;

  get estimationStream => _estimationCostController.stream;

  get changeTextStream => _mainButtonTextController.stream;

  get loadingStream => _loadingController.stream;

  get feedbackStream => _feedbackController.stream;

  get helpStream => _helpController.stream;

  get noteButtonStream => _noteButtonController.stream;

  get showNoteButton => _noteButtonController.sink.add(true);

  get hideNoteButton => _noteButtonController.sink.add(false);

  Stream<Type> get carTypeStream => _carTypeController.stream;

  Stream<Gender> get genderStream => _genderController.stream;

  Stream<int> get numberOfSeatsStream => _numberOfSeatsController.stream;

  get showFiltersStream => _modalController.stream;

  get showModal => _modalController.sink.add(true);
  get hideModal => _modalController.sink.add(false);

  get productionDateStream => _productionDateController.stream;


  changeButtonText(String text) => _mainButtonTextController.sink.add(text);

  pushLoading(bool load) => _loadingController.sink.add(load);







  final _couponsController = BehaviorSubject<Coupon>();

  get couponStream => _couponsController.stream;

  fetchCoupon(String s) {

    fetchCheckCoupon(token, s).then((coupon) {

      _couponsController.sink.add(coupon);


    }).catchError((e) {

    });

  }




  get navBackward {
//    if(trip.inCity){
//      if(index == 4 ) {index =3 ;done = false;
//      pushLoading(false);
//      changeButtonText('next'); }
//    }
    if (!trip.inCity) {
      if (index == 4) index =3 ;
      if (index == 5 ) index =4;
//      if (index == 4) index = 3;
      _navigationController.sink.add(--index);
    } else {
      _navigationController.sink.add(--index);
      if(index ==3){
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
      }
      if(index == 6)
        {
          hideNoteButton;

        }
    }
    if (index == 0 || index == 1 || index == 2 ) {
      done = false;
      pushLoading(false);
      changeButtonText('next');
      hideNoteButton;
    }
//    if(index == 6)
//      {
//        hideNoteButton;
//      }
  }

  get navForward {
    if (_shouldNav()) {
      if (index == 6) {
        print(index);
        hideNoteButton;
        _navigationController.sink.add(index);
      } else {
        _navigationController.sink.add(++index);
      }
      print("index is $index" );


      done = false;

      if(index == 5 ){
        changeButtonText('done');
        pushLoading(true);

        done = true;

      }
      if (index == 4) {
        showNoteButton;
        done =  true;
      }
      if (trip.inCity) {
        if (index == 4) {
          pushLoading(false);
          showNoteButton;
          done = false;
          changeButtonText('next');
        }
      } else {
        if (index == 3) {
          showNoteButton;
          done = false;

          index = 4;

        }
      }
    } else {}
    if (index == 0 || index == 1 || index == 2 || index ==3) {
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
    print("Submitttttttttttttttttttttttttttttttttttttted");
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

  selectGender(Gender gender) {
    _genderController.sink.add(gender);
    this.gender = gender;
  }

  selectCarType(Type type) {
    _carTypeController.sink.add(type);
    this.type = type;
  }

  plusSeat() {
    _numberOfSeatsController.sink.add(++numberOfSeats);
  }

  minusSeat() {
    if (numberOfSeats > 2) _numberOfSeatsController.sink.add(--numberOfSeats);
  }

  clearNumberOfSeats() {
    numberOfSeats = 1;
    _numberOfSeatsController.add(numberOfSeats);
  }

  get languagesStream => _languagesController.stream;

  selectLanguage(String langId) {
    langFiltersIds.add(langId);
    _languagesIdsController.sink.add(langFiltersIds);
  }

  removeLanguage(String langId) {
    langFiltersIds.removeWhere((id) => id == langId);
    _languagesIdsController.sink.add(langFiltersIds);
  }

  getLanguages() {
    fetchLanguages(token).then((languages) {
      _languagesController.sink.add(languages);
    });
  }

  get languagesIdsStream => _languagesIdsController.stream;

  @override
  void dispose() {
    _navigationController.close();
    _tripController.close();
    _estimationCostController.close();
    _mainButtonTextController.close();
    _loadingController.close();
    _feedbackController.close();
    _helpController.close();
    _noteButtonController.close();
    _carTypeController.close();
    _genderController.close();
    _numberOfSeatsController.close();
    _languagesController.close();
    _languagesIdsController.close();
    _modalController.close();
    _productionDateController.close();
    _couponsController.close();

  }

  selectProductionDate(String value) {
    _productionDateController.sink.add(value);
    productionDate = value;
  }

  void clearProductionDate() {
    productionDate = null;
    _productionDateController.sink.add(productionDate);
  }

}

enum Gender { male, female, none }

enum Type { vip, normal, none }
