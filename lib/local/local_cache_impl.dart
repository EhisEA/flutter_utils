import 'dart:convert';
import 'package:flutter_utils/local/local_cache.dart';
import 'package:flutter_utils/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCacheImpl implements LocalCache {
  static const _tokenKey = 'userToken';
  static const _userDataKey = 'userData';
  late final _log = const AppLogger(LocalCacheImpl);
  final String? userDataStorageKey;
  late SharedPreferences _sharedPreferences;
  String get _userKey => userDataStorageKey ?? _userDataKey;

  LocalCacheImpl({
    required SharedPreferences sharedPreferences,
    this.userDataStorageKey,
  }) {
    _sharedPreferences = sharedPreferences;
  }

  @override
  Future<void> deleteToken() async {
    try {
      await removeFromLocalCache(_tokenKey);
    } catch (e) {
      _log.e('Failed to delete token: $e');
    }
  }

  @override
  Object? getFromLocalCache(String key) {
    try {
      return _sharedPreferences.get(key);
    } catch (e) {
      _log.e('Failed to get value for key "$key": $e');
      return null;
    }
  }

  @override
  String? getToken() {
    return getFromLocalCache(_tokenKey) as String?;
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (e) {
      _log.e('Failed to remove value for key "$key": $e');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await saveToLocalCache(key: _tokenKey, value: token);
  }

  @override
  Future<void> saveToLocalCache(
      {required String key, required dynamic value}) async {
    _log.i(
        'Saving data: key="$key", value="$value", type="${value.runtimeType}"');

    try {
      if (value is String) {
        await _sharedPreferences.setString(key, value);
      } else if (value is bool) {
        await _sharedPreferences.setBool(key, value);
      } else if (value is int) {
        await _sharedPreferences.setInt(key, value);
      } else if (value is double) {
        await _sharedPreferences.setDouble(key, value);
      } else if (value is List<String>) {
        await _sharedPreferences.setStringList(key, value);
      } else if (value is Map || value is List<Map>) {
        await _sharedPreferences.setString(key, json.encode(value));
      } else {
        throw ArgumentError('Unsupported value type: ${value.runtimeType}');
      }
    } catch (e) {
      _log.e('Failed to save value for key "$key": $e');
      rethrow;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _sharedPreferences.clear();
    } catch (e) {
      _log.e('Failed to clear cache: $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic>? getUserData() {
    try {
      final data = getFromLocalCache(_userKey) as String?;
      return data != null ? jsonDecode(data) as Map<String, dynamic> : null;
    } catch (e) {
      _log.e('Failed to get user data: $e');
      return null;
    }
  }

  @override
  Map? getMapData(String key) {
    try {
      final data = getFromLocalCache(key) as String?;
      return data != null ? jsonDecode(data) as Map : null;
    } catch (e) {
      _log.e('Failed to get user data: $e');
      return null;
    }
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> json) async {
    await saveToLocalCache(key: _userKey, value: json);
  }
}
