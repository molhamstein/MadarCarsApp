import 'package:madar_booking/DataStore.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BaseBloc with Network {
  final SharedPreferences _prefs;
  DataStore _dataStore;

  final _userController = BehaviorSubject<bool>();
  final _logOutController = PublishSubject<bool>();

  AppBloc(this._prefs) {
    _dataStore = DataStore(_prefs);
  }

  Stream<bool> get authenticationStream => _userController.stream;

  Stream<bool> get logOutStream => _logOutController.stream;

  get pushUser => _userController.sink.add(_dataStore.isUserLoggedIn);

  Function(User) get saveUser => _dataStore.setUser;

  Function(List<TripModel>) get saveRecomendedTrips =>
      _dataStore.recomendedTripList;

  List<TripModel> get recomendedTrips => _dataStore.getRecomendedTripList();

  Function(List<MyTrip>) get saveMyTrips => _dataStore.myTripList;

  List<MyTrip> get myTrips => _dataStore.getMyTripList();

  Function(List<Car>) get saveOurCars => _dataStore.ourCars;

  List<Car> get ourCars => _dataStore.getOurCars();

  Function(String) get saveToken => _dataStore.setUserToken;

  String get phone => _dataStore.getUser().phoneNumber != null
      ? _dataStore.getUser().phoneNumber
      : "";

  String get userName => _dataStore.getUser().name != null
      ? _dataStore.getUser().name
      : ""; //TODO remove; only for testing
  String get token => _dataStore.userToken;

  String get userId => _dataStore.getUser().id;

  String get userImage => _dataStore.userImage;

  String get userISOCode =>
      _dataStore.userISOCode != null ? _dataStore.userISOCode : "";

  User get me => _dataStore.getUser();

  get logout {
    putLogout(token,(){
      print("sfsfsdfsfsf");

      _dataStore.logout;
      _logOutController.sink.add(true);
    });
  }

  get pushStopLoop {
    // TODO change!
    _logOutController.sink.add(false);
  }

  @override
  void dispose() {
    _userController.close();
    _logOutController.close();
  }
}
