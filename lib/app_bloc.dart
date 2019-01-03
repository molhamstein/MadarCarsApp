import 'package:madar_booking/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BaseBloc{
  final SharedPreferences _prefs;


  final _prefsController = BehaviorSubject<SharedPreferences>();

  AppBloc(this._prefs);

  get pushPrefs => _prefsController.sink.add(_prefs);
  Stream<SharedPreferences> get streamPrefs => _prefsController.stream;


  @override
  void dispose() {
    _prefsController.close();
  }

}