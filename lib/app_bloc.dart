import 'package:madar_booking/DataStore.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BaseBloc{
  final SharedPreferences _prefs;
  DataStore _dataStore;


  final _userController = BehaviorSubject<bool>();

  AppBloc(this._prefs){
    _dataStore = DataStore(_prefs);
  }

  Stream<bool> get authenticationStream => _userController.stream;
  get pushUser => _userController.sink.add(_dataStore.isUserLoggedIn);
  Function(User) get saveUser => _dataStore.setUser;
  Function(String) get saveToken => _dataStore.setUserToken;


  @override
  void dispose() {
    _userController.close();
  }

}