library storage_service;

import 'package:storage_test/services/storage_service/impl/storage_service_hive.impl.dart';
import 'package:storage_test/services/storage_service/index.dart';

import 'impl/storage_service_shared_prefs.impl.dart';

class StorageServiceManager {
  static Future<StorageService> create([bool useHive = true]) async {
    if ( useHive ) {
      return StorageServiceHive().internalInit();
    } else {
      return StorageServiceSharedPrefs().internalInit();
    }
  }
}