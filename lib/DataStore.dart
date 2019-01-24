import 'dart:convert';

import 'package:madar_booking/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  final SharedPreferences _prefs;

  DataStore(this._prefs);

  User getUser() {
    final json = {
      User.ID: _prefs.get('user_id'),
      User.USER_NAME: _prefs.get('user_username'),
      User.PHONE_NUMBER: _prefs.get('user_phone_number'),
      User.STATUS: _prefs.get('user_status'),
      User.CREATED_AT: _prefs.get('user_created_at'),
    };
    return User.fromJson(json);
  }

  setUser(User user) {
    print('hahahahahahha' + user.name);
    _prefs.setString('user_id', user.id);
    _prefs.setString('user_username', user.name);
    _prefs.setString('user_phone_number', user.phoneNumber);
    if (user.media != null) _prefs.setString('user_image', user.media.url);
    _prefs.setString('user_status', user.status);
    _prefs.setString('user_created_at', user.createdAt);
    _prefs.setString('user', json.encode(user.toJson()));
  }

  setUserToken(String accessToken) {
    _prefs.setString('access_token', accessToken);
  }

  String get userImage => _prefs.getString('user_image');

  // User get me => User.fromJson(_prefs.getString('user'));
  String get userToken => _prefs.getString('access_token');

  bool get isUserLoggedIn => _prefs.getString('access_token') != null;

  get logout => _prefs.clear();
}
