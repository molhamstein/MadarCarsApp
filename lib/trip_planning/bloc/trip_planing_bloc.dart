import 'dart:async';

import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Airport.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/CouponModel.dart';
import 'package:madar_booking/models/Language.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

enum Steps {
  chooseCity,
  chooseType,
  chooseAirports,
  chooseDate,
  chooseCar,
  chooseSuplocations,
  summary,
  finalstep
}

class TripPlaningBloc extends BaseBloc with Network {
  Trip trip;

  // int index;
  Steps step;
  bool done;
  String token;
  String userId;
  bool showFeedback;
  bool isPredefinedTrip;
  int numberOfSeats;
  Gender gender;
  String productionDate;
  List<String> langFiltersIds;
  String couponid;

  List<Airport> airports;

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
    // index = 0;
    step = Steps.chooseCity;
    done = false;
    this.token = token;
    this.userId = userId;
    showFeedback = false;
    numberOfSeats = 1;
    langFiltersIds = [];
    _languagesIdsController.sink.add(langFiltersIds);
    airports = [];
  }

  final _navigationController = BehaviorSubject<Steps>();
  final _tripController = BehaviorSubject<Trip>();
  final _estimationCostController = PublishSubject<int>();
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
  final _dateController = PublishSubject<bool>();
  final _startDateController = BehaviorSubject<DateTime>();
  final _endDateController = BehaviorSubject<DateTime>();

  get startDateStream => _startDateController.stream;

  get endtDateStream => _endDateController.stream;

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

  get dateChangedStream => _dateController.stream;

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

//  addPaymentForTrip(String tripId ,double price , String cardHolderName ,double cardNumber , double expireMonth , double expireYear , cvc){
//    addPayment(tripId , price , cardHolderName , cardNumber, expireMonth , expireYear , cvc).then((data){
//      print(data);
//    }).catchError((e){
//      print(e);
//    });
//  }

  final _gettingPdf = BehaviorSubject<bool>();

  get gettingPdfStream => _gettingPdf.stream;

  f_createPDF(tripId, onData) {
    _gettingPdf.sink.add(true);
    createPDF(tripId, token).then((value) {
      print("path ");
      print(value);
      onData(value);
      trip.pdfPath = value;
      _gettingPdf.sink.add(false);
    }).catchError((e) {
      _gettingPdf.sink.add(false);
    });
  }

  addPaymentForTrip(Trip trip) {
    showFeedback = true;
    if (trip.cardNumber == null ||
        trip.cardHolderName == null ||
        trip.expireYear == null ||
        trip.expireMonth == null ||
        trip.cvc == null) {
      _feedbackController.sink.addError('error_fill_missing');
    } else
      addPayment(trip, token).then((data) {
        print(data);
        navForward;
      }).catchError((e) {
        print("eeeeeeeeeeeeeeeeeeeeeeeeee" + e.toString());
        showFeedback = true;
        _feedbackController.addError(e.toString());
      });
  }

  fetchCoupon(String s) {
    fetchCheckCoupon(token, s).then((coupon) {
      _couponsController.sink.add(coupon);
      showFeedback = false;
    }).catchError((e) {
      _couponsController.sink.addError(e);
      showFeedback = true;
      _feedbackController.sink.addError('Coupn_not_available');
    });
  }

  get navBackward {
    switch (step) {
      case Steps.chooseCity:
        break;
      case Steps.chooseType:
        step = Steps.chooseCity;
        break;
      case Steps.chooseAirports:
        step = Steps.chooseType;
        break;
      case Steps.chooseDate:
        if ((trip.toAirport || trip.fromAirport) && trip.hasManyAirport) {
          step = Steps.chooseAirports;
        } else {
          step = Steps.chooseType;
        }
        break;
      case Steps.chooseCar:
        step = Steps.chooseDate;
        break;
      case Steps.chooseSuplocations:
        step = Steps.chooseCar;
        break;
      case Steps.summary:
        if (trip.inCity) {
          step = Steps.chooseSuplocations;
        } else {
          step = Steps.chooseCar;
        }
        break;
      case Steps.finalstep:
        break;
      default:
    }
    _navigationController.sink.add(step);
    setState();
  }

  get navForward {
    if (!_shouldNav()) return;
    switch (step) {
      case Steps.chooseCity:
        step = Steps.chooseType;
        break;
      case Steps.chooseType:
        if ((trip.toAirport || trip.fromAirport) && trip.hasManyAirport) {
          step = Steps.chooseAirports;
        } else {
          step = Steps.chooseDate;
        }
        break;
      case Steps.chooseAirports:
        step = Steps.chooseDate;
        break;
      case Steps.chooseDate:
        step = Steps.chooseCar;
        break;
      case Steps.chooseCar:
        if (trip.inCity) {
          step = Steps.chooseSuplocations;
        } else {
          step = Steps.summary;
        }
        break;
      case Steps.chooseSuplocations:
        step = Steps.summary;
        break;
      case Steps.summary:
        step = Steps.finalstep;
        break;
      case Steps.finalstep:
        break;
      default:
    }
    _navigationController.sink.add(step);
    setState();
  }

  _shouldNav() {
    switch (step) {
      case Steps.chooseCity:
        if (trip.location != null) {
          return true;
        }
        return false;
      case Steps.chooseType:
        if (!trip.toAirport && !trip.fromAirport && !trip.inCity) {
          showFeedback = true;
          _feedbackController.sink.addError('error_fill_missing');
          return false;
        }
        return true;
      case Steps.chooseAirports:
        if (trip.airport == null) {
          showFeedback = true;
          _feedbackController.sink.addError('error_fill_missing');
          return false;
        }
        return true;
      case Steps.chooseDate:
        if (trip.inCity || (trip.toAirport && trip.fromAirport)) {
          if (trip.endDate.isBefore(trip.startDate)) {
            // endDateChanged(trip.startDate);
            showFeedback = true;
            _feedbackController.sink
                .addError('error_end_date_before_start_date');
            return false;
          }
        }
        return true;
      case Steps.chooseCar:
        if (trip.car != null) {
          return true;
        } else {
          showFeedback = true;
          _feedbackController.sink.addError('error_fill_missing');
        }
        return false;
      case Steps.chooseSuplocations:
        return true;
      case Steps.summary:
        return true;
      case Steps.finalstep:
        return true;
      default:
        return true;
    }
  }

//  setState() {
//    done = false;
//    showFeedback = false;
//    switch (step) {
//      case Steps.chooseCity:
//        done = false;
//        pushLoading(false);
//        changeButtonText('next');
//        hideNoteButton;
//        break;
//      case Steps.chooseType:
//        done = false;
//        pushLoading(false);
//        changeButtonText('next');
//        hideNoteButton;
//        break;
//      case Steps.chooseAirports:
//        done = false;
//        pushLoading(false);
//        changeButtonText('next');
//        hideNoteButton;
//        break;
//      case Steps.chooseDate:
//        done = false;
//        pushLoading(false);
//        changeButtonText('next');
//        hideNoteButton;
//        break;
//      case Steps.chooseCar:
//        done = false;
//        pushLoading(false);
//        changeButtonText('next');
//        showNoteButton;
//        break;
//      case Steps.chooseSuplocations:
//        done = false;
//        pushLoading(false);
//        changeButtonText('next');
//        showNoteButton;
//        break;
//      case Steps.summary:
//        changeButtonText('done');
//        pushLoading(true);
//        done = true;
//        showNoteButton;
//        break;
//      case Steps.finalstep:
//        changeButtonText('done');
//        pushLoading(false);
//        hideNoteButton;
//        break;
//      default:
//    }
//  }

  setState() {
    done = false;
    showFeedback = false;
    switch (step) {
      case Steps.chooseCity:
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
        break;
      case Steps.chooseType:
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
        break;
      case Steps.chooseAirports:
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
        break;
      case Steps.chooseDate:
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
        break;
      case Steps.chooseCar:
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
        break;
      case Steps.chooseSuplocations:
        done = false;
        pushLoading(false);
        changeButtonText('next');
        hideNoteButton;
        break;
      case Steps.summary:
        changeButtonText('pay_now');
        pushLoading(false);
        done = true;
        showNoteButton;
        break;
      case Steps.finalstep:
        changeButtonText('done');
        pushLoading(false);
        hideNoteButton;
        break;
      default:
    }
  }

//       case Steps.chooseCity:
//       case Steps.chooseType:
//       case Steps.chooseAirports:
//       case Steps.chooseDate:
//       case Steps.chooseCar:
//       case Steps.chooseSuplocations:
//       case Steps.summary:
//       case Steps.finalstep:
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
    // if (trip.endDate.isBefore(trip.startDate)) {
    //  endDateChanged(trip.startDate);
    // }
    //_dateController.sink.add(true);
    _startDateController.sink.add(startDate);
  }

  endDateChanged(endDate) {
    trip.endDate = endDate;
    // if (trip.endDate.isBefore(trip.startDate)) {
    //   endDateChanged(trip.startDate);
    //  }
    // _dateController.sink.add(true);
    _endDateController.sink.add(endDate);
  }

  cityId(Location location) {
    if (location.locationId == null) {
      trip.location = location;
      print("location is null : true true ");
    }
//      else if(location.locationId != null)
//        {
//          print ("location is null : false false");
//
//
//        }
  }

  tripCar(Car car) {
    trip.car = car;
    trip.tripSubLocations.clear();
  }

  Function(String, int, int, String) get addSubLocation => trip.addSubLocation;

  // new function for add day by day sublocations
  Function(String, int, int, String, int) get addSubLocations =>
      trip.addSubLocations;

  Function(int, int) get editSubLocation => trip.editSubLocation;

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
      _feedbackController.sink.add("trip_added_successfully");
      navForward;
      trip.tripId = d;
    }).catchError((e) {
      print("e is : " + e.toString());
      if (e.toString() != "error_car_not_available") {
        print(e['error']['details'].toString());
        trip.tripId = e['error']['details'];
        print(trip.tripId);
      }

      _loadingController.sink.add(false);
      Future.delayed(Duration(milliseconds: 10)).then((s) {
        if ((step == Steps.chooseCar && !trip.inCity) ||
            step == Steps.chooseSuplocations) _loadingController.sink.add(true);
      });
      if (e.toString() != "error_car_not_available") {
        _feedbackController
            .addError('YOUR_TRIP_HAS_BEEN_ADDED_BUT_PAYMENT_INFO_IS_WRONG');
      } else
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
    _startDateController.close();
    _endDateController.close();
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
