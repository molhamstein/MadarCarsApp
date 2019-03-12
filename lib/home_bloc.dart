import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc with Network {
  final token;
  HomeBloc(this.token);
  // avaliable Car Bloc
  final _availableCarController = BehaviorSubject<List<Car>>();
  Function(List<Car>) get insertCarList => _availableCarController.sink.add;
  Stream<List<Car>> get availableCarsStream => _availableCarController.stream;
  // predefined Trips Bloc
  final _predefinedTripsController = BehaviorSubject<List<TripModel>>();
  Function(List<TripModel>) get insertTripList =>
      _predefinedTripsController.sink.add;
  Stream<List<TripModel>> get predefindTripsStream =>
      _predefinedTripsController.stream;

  getCars() {
    getAvailableCars(token).then((response) {
      print(response);
      _availableCarController.sink.add(response);
    }).catchError((e) {
      print(e);
      print('cars error');
      _availableCarController.sink.addError(e);
    });
  }

  predifindTrips() {
    getPredifinedTrips(token).then((response) {
      print(response);
      _predefinedTripsController.sink.add(response);
    }).catchError((e) {
      print(e);
      _predefinedTripsController.sink.addError(e);
    });
  }

  updateFirebaseToken(String firebaseToken, String deviceId) {
    updateFirebaseTokens(token, firebaseToken, deviceId);
  }

  postFirebaseToken(String firebaseToken, String deviceId) {
    postFirebaseTokens(token, firebaseToken, deviceId);
  }

  @override
  void dispose() {
    //_availableCarController.close();
    //  _predefinedTripsController.close();
  }
}
