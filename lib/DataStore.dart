import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  var _cahce_key = "volume";
  get CACHE_KEY => _cahce_key;

  set CACHE_KEY(CACHE_KEY) {
    _cahce_key = CACHE_KEY;
  }

  var _cahce_key_int = "favorites";

  get chache_key_int => _cahce_key_int;

  set chache_key_int(chache_key_int) {
    _cahce_key_int = chache_key_int;
  }

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static SharedPreferences _prefsInstance;

  static bool _initCalled = false;

  static Future init() async {
    _initCalled = true;
    _prefsInstance = await _prefs;
  }

  static void dispose() {
    _prefs = null;
    _prefsInstance = null;
  }

  static final DataStore _singleton = new DataStore._internal();
  factory DataStore() {
    return _singleton;
  }

  DataStore._internal() {
    init();
    print("init");
  }

  get counter => getInt(_cahce_key_int);
  set counter(counter) {
    setInt(_cahce_key_int, counter);
  }

  /// Returns all keys in the persistent storage.
  static Set<String> getKeys() {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getKeysF() instead. SharedPreferences not ready yet!");
    return _prefsInstance.getKeys();
  }

  /// Returns a Future.
  static Future<Set<String>> getKeysF() async {
    Set<String> value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.getKeys() ?? Set();
    } else {
      value = getKeys();
    }
    return value;
  }

  /// Reads a value of any type from persistent storage.
  static dynamic get(String key) {
    print("error");
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    print("error 2");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance.get(key);
  }

  /// Returns a Future.
  static Future<dynamic> getF(String key) async {
    dynamic value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.get(key);
    } else {
      value = get(key);
    }
    return value;
  }

  static bool getBool(String key, [bool defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getBoolF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  /// Returns a Future.
  static Future<bool> getBoolF(String key, [bool defValue]) async {
    bool value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.getBool(key) ?? defValue ?? false;
    } else {
      value = getBool(key);
    }
    return value;
  }

  static int getInt(String key, [int defValue]) {
    print("error");
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getIntF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance.getInt(key) ?? defValue ?? 0;
  }

  /// Returns a Future.
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

  static double getDouble(String key, [double defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getDoubleF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance.getDouble(key) ?? defValue ?? 0.0;
  }

  /// Returns a Future.
  static Future<double> getDoubleF(String key, [double defValue]) async {
    double value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.getDouble(key) ?? defValue ?? 0.0;
    } else {
      value = getDouble(key);
    }
    return value;
  }

  static String getString(String key, [String defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getStringF(key)instead. SharedPreferences not ready yet!");
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  /// Returns a Future.
  static Future<String> getStringF(String key, [String defValue]) async {
    String value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.getString(key) ?? defValue ?? "";
    } else {
      value = getString(key);
    }
    return value;
  }

  static List<String> getStringList(String key, [List<String> defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getStringListF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance.getStringList(key) ?? defValue ?? [""];
  }

  /// Returns a Future.
  static Future<List<String>> getStringListF(String key,
      [List<String> defValue]) async {
    List<String> value;
    if (_prefsInstance == null) {
      var instance = await _prefs;
      value = instance?.getStringList(key) ?? defValue ?? [""];
    } else {
      value = getStringList(key);
    }
    return value;
  }

  /// Saves a boolean [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setBool(String key, bool value) async {
    var instance = await _prefs;
    return instance?.setBool(key, value) ?? Future.value(false);
  }

  /// Saves an integer [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setInt(String key, int value) async {
    var instance = await _prefs;
    return instance?.setInt(key, value) ?? Future.value(false);
  }

  /// Saves a double [value] to persistent storage in the background.
  /// Android doesn't support storing doubles, so it will be stored as a float.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setDouble(String key, double value) async {
    var instance = await _prefs;
    return instance?.setDouble(key, value) ?? Future.value(false);
  }

  /// Saves a string [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setString(String key, String value) async {
    var instance = await _prefs;
    return instance?.setString(key, value) ?? Future.value(false);
  }

  /// Saves a list of strings [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setStringList(String key, List<String> value) async {
    var instance = await _prefs;
    return instance?.setStringList(key, value) ?? Future.value(false);
  }

  /// Removes an entry from persistent storage.
  static Future<bool> remove(String key) async {
    var instance = await _prefs;
    return instance?.remove(key) ?? Future.value(false);
  }

  /// Completes with true once the user preferences for the app has been cleared.
  static Future<bool> clear() async {
    var instance = await _prefs;
    return instance?.clear() ?? Future.value(false);
  }
}
