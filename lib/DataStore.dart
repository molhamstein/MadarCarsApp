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
      'ISOCode': _prefs.get('user_ISO_code')
    };
    return User.fromJson(json);
  }

  setUser(User user) {
    print('hahahahahahha' + user.name);
    _prefs.setString('user_id', user.id);
    _prefs.setString('user_username', user.name);
    _prefs.setString('user_phone_number', user.phoneNumber);
    _prefs.setString('user_ISO_code', user.isoCode);
    if (user.media != null) _prefs.setString('user_image', user.media.url);
    _prefs.setString('user_status', user.status);
    _prefs.setString('user_created_at', user.createdAt);
  }

  setUserToken(String accessToken) {
    _prefs.setString('access_token', accessToken);
  }

  String get userImage => _prefs.getString('user_image');
  String get userISOCode => _prefs.getString('user_ISO_code');

  // User get me => User.fromJson(_prefs.getString('user'));
  String get userToken => _prefs.getString('access_token');

  bool get isUserLoggedIn => _prefs.getString('access_token') != null;

  get logout => _prefs.clear();
}
