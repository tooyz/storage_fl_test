library storage_service;

import 'package:path_provider/path_provider.dart';
import 'package:storage_test/services/storage_service/index.dart';
import 'package:hive/hive.dart';

class StorageServiceHive extends StorageService {
  CollectionBox<dynamic>? _box;

  @override
  Future<StorageService> internalInit() async {
    final directory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'hivebox',
      {'app'},
      path: directory.path,
    );
    _box = await collection.openBox<dynamic>('app');

    return this;
  }

  @override
  Future<bool> remove(String key) {
    try {
      _box!.delete(key);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await _box!.clear();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<T?> read<T>(String key, {T? defaultValue}) async {
    var result = await _box!.get(key) as T?;
    if (T == bool) {
      return (result ?? defaultValue ?? false) as T;
    }
    if (result != null) {
      return result;
    }
    return defaultValue;
  }

  @override
  Future<bool> write<T>(String key, T value) async {
    try {
      _box!.put(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  String get backend => 'hive';
}
