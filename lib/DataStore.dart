import 'dart:convert';

import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  final SharedPreferences _prefs;

  DataStore(this._prefs);

  User getUser() {
    // final json = {
    //   User.ID: _prefs.get('user_id'),
    //   User.USER_NAME: _prefs.get('user_username'),
    //   User.PHONE_NUMBER: _prefs.get('user_phone_number'),
    //   User.STATUS: _prefs.get('user_status'),
    //   User.CREATED_AT: _prefs.get('user_created_at'),
    //   'ISOCode': _prefs.get('user_ISO_code')
    // };
    // return User.fromJson(json);
    var userStr = _prefs.getString("user");
    var u = userStr != null ? userFromJson(userStr) : User();
    return u;
  }

  setUser(User user) {
    print('hahahahahahha');

    // _prefs.setString('user_id', user.id);
    // _prefs.setString('user_username', user.name);
    // _prefs.setString('user_phone_number', user.phoneNumber);
    // _prefs.setString('user_ISO_code', user.isoCode);
    if (user.media != null) _prefs.setString('user_image', user.media.url);
    // _prefs.setString('user_status', user.status);
    // _prefs.setString('user_created_at', user.createdAt);
    print("save user");
    _prefs.setString("user", userToJson(user));
  }

  User getSavedUser() {
    var userStr = _prefs.getString("user");
    return userFromJson(userStr);
  }

  saveUser(User user) {
    print("save user");
    _prefs.setString("user", userToJson(user));
  }

  //////////////////////
  saveStartDate(var date) {
    date = _prefs.setString("startDate", date);
  }

  saveEndDate(var date) {
    date = _prefs.setString("EndDate", date);
  }

  saveEstimCost(var estim) {
    estim = _prefs.setInt("Estim", estim);
  }

  saveCarName(var carName) {
    _prefs.setString("CarName", carName);
  }

  getCarName() {
    var carName = _prefs.getString("CarName");
    print(carName);
    return carName;
  }

  saveCarPrice(var carPrice) {
    carPrice = _prefs.setString("CarPrice", carPrice);
  }

  saveAirportPickUp() {}
//////////////////////

  setUserToken(String accessToken) {
    _prefs.setString('access_token', accessToken);
  }

  List<TripModel> getRecomendedTripList() {
    var trips = _prefs.getString("recomendedTrips");
    List<TripModel> t = trips != null ? tripFromJson(trips) : [];
    return t;
  }

  recomendedTripList(List<TripModel> trips) {
    _prefs.setString("recomendedTrips", tripToJson(trips));
  }

  List<MyTrip> getMyTripList() {
    var trips = _prefs.getString("myTips");
    List<MyTrip> t = trips != null ? myTripFromJson(trips) : [];
    return t;
  }

  myTripList(List<MyTrip> trips) {
    _prefs.setString("myTips", myTripToJson(trips));
  }

  List<Car> getOurCars() {
    var cars = _prefs.getString("ourCars");
    List<Car> c = cars != null ? carFromJson(cars) : [];
    return c;
  }

  ourCars(List<Car> cars) {
    _prefs.setString("ourCars", carToJson(cars));
  }

  String get userImage => _prefs.getString('user_image');
  String get userISOCode => me.isoCode;

  User get me => getUser();
  String get userToken => _prefs.getString('access_token');

  bool get isUserLoggedIn => _prefs.getString('access_token') != null;

  get logout => _prefs.clear();
}
