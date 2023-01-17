library token_service;

import 'package:storage_test/services/storage_service/index.dart';

class TokenService {
  final StorageService _storage;

  final String _accessKey = 'accessToken';
  final String _refreshKey = 'refreshToken';
  final String _idKey = 'idToken';

  TokenService(this._storage);

  Future<bool> setIdToken(String token) {
    return _storage.write(_idKey, token);
  }

  Future<bool> setAccessToken(String token) {
    return _storage.write(_accessKey, token);
  }

  Future<bool> setRefreshToken(String token) {
    return _storage.write(_refreshKey, token);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(_refreshKey);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(_accessKey);
  }

  Future<String?> getIdToken() {
    return _storage.read(_idKey);
  }

  Future<bool> clear() {
    return _storage.clear();
  }
}