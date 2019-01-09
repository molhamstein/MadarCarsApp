import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static SharedPreferences _prefsInstance;
  static bool _initCalled = false;
  static final DataStore _singleton = new DataStore._internal();
  factory DataStore() {
    return _singleton;
  }

  DataStore._internal() {
    init();
    print("init");
  }

  static Future<void> init() async {
    _initCalled = true;
    _prefsInstance = await _prefs;
    print("initttt");
  }

  int get counter => getInt('c');
  set counter(int c) => _prefsInstance.setInt('c', c);

  static int getInt(String key, [int defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getIntF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance.getInt(key) ?? defValue ?? 0;
  }

  static Future<int> getIntF(String key, [int defValue]) async {
    int value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.getInt(key) ?? defValue ?? 0;
    } else {
      value = getInt(key);
    }
    return value;
  }
}
