library storage_service;

import 'package:meta/meta.dart';

abstract class StorageService {
  Future<T?> read<T>(String key, {T? defaultValue});
  Future<bool> write<T>(String key, T value);
  Future<bool> remove(String key);
  Future<bool> clear();
  @protected
  void internalInit();
  String get backend;
}