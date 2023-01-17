library storage_service;

import 'package:storage_test/services/storage_service/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceSharedPrefs extends StorageService {
  SharedPreferences? _prefs;

  @override
  Future<StorageService> internalInit() async {
    _prefs = await SharedPreferences.getInstance();

    return this;
  }

  @override
  Future<bool> remove(String key) {
    return _prefs!.remove(key);
  }

  @override
  Future<bool> clear() {
    return _prefs!.clear();
  }

  @override
  Future<T?> read<T>(String key, {T? defaultValue}) async {
    var result = _prefs!.get(key) as T?;
    if ( T == bool ) {
      return ( result ?? defaultValue ?? false ) as T;
    }
    if ( result != null ) {
      return result;
    }
    return defaultValue;
  }

  @override
  Future<bool> write<T>(String key, T value) async {
    if (value is int) {
      return _prefs!.setInt(key, value);
    }
    if (value is double) {
      return _prefs!.setDouble(key, value);
    }
    if (value is String) {
      return _prefs!.setString(key, value);
    }
    if (value is bool) {
      return _prefs!.setBool(key, value);
    }
    if (value is List<String>) {
      return _prefs!.setStringList(key, value);
    }
    if (value != null) {
      throw ArgumentError('Invalid value type in StorageService.write');
    }
    return false;
  }

  @override
  String get backend => 'shared_prefs';
}