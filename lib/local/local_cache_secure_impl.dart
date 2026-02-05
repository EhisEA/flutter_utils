import 'dart:convert';

import 'package:flutter_utils/local/flutter_secure_storage_adapter.dart';
import 'package:flutter_utils/local/local_cache.dart';
import 'package:flutter_utils/local/secure_storage_port.dart';
import 'package:flutter_utils/utils/utils.dart';

/// Secure implementation of [LocalCache] that stores all data in platform
/// secure storage (Keychain on iOS, EncryptedSharedPreferences/KeyStore on Android).
///
/// Prefer [create] to get an initialized cache in one call. Otherwise construct
/// and call [init] before use.
///
/// Example:
/// ```dart
/// final cache = await LocalCacheSecureImpl.create();
/// // cache is ready; get/save work immediately
/// ```
class LocalCacheSecureImpl implements LocalCache {
  static const _tokenKey = 'userToken';
  static const _userDataKey = 'userData';
  late final _log = const AppLogger(LocalCacheSecureImpl);

  final SecureStoragePort _secureStorage;
  final String? userDataStorageKey;
  String get _userKey => userDataStorageKey ?? _userDataKey;

  /// In-memory copy of stored strings (encoded with type) for sync reads.
  final Map<String, String> _store = {};
  String? _memoryToken;
  Map<String, dynamic>? _memoryUserData;
  bool _initialized = false;

  LocalCacheSecureImpl({
    SecureStoragePort? secureStorage,
    this.userDataStorageKey,
  }) : _secureStorage = secureStorage ?? FlutterSecureStorageAdapter();

  /// Returns an initialized cache ready to use. Prefer this over constructor + [init].
  static Future<LocalCacheSecureImpl> create({
    SecureStoragePort? secureStorage,
    String? userDataStorageKey,
  }) async {
    final cache = LocalCacheSecureImpl(
      secureStorage: secureStorage,
      userDataStorageKey: userDataStorageKey,
    );
    await cache.init();
    return cache;
  }

  /// Loads all data from secure storage into memory. Call once after construction
  /// if not using [create].
  Future<void> init() async {
    if (_initialized) return;
    try {
      final all = await _secureStorage.readAll();
      _store.clear();
      _store.addAll(all);

      final tokenRaw = _store[_tokenKey];
      if (tokenRaw != null) {
        if (tokenRaw.startsWith(_envelopePrefix)) {
          final decoded = _decodeEnvelope(tokenRaw);
          _memoryToken = decoded is String ? decoded : null;
        } else {
          _memoryToken = tokenRaw;
        }
      } else {
        _memoryToken = null;
      }

      final userDataStr = _store[_userKey];
      if (userDataStr != null) {
        final decoded = _decodeEnvelope(userDataStr);
        if (decoded is Map<String, dynamic>) {
          _memoryUserData = decoded;
        } else if (decoded is String) {
          final fromJson = jsonDecode(decoded);
          _memoryUserData = fromJson is Map<String, dynamic> ? fromJson : null;
        } else {
          _memoryUserData = null;
        }
      } else {
        _memoryUserData = null;
      }
    } catch (e) {
      _log.e('Failed to init secure cache: $e');
    }
    _initialized = true;
  }

  static const _envelopePrefix = '{"t":';
  static const _typeString = 's';
  static const _typeInt = 'i';
  static const _typeBool = 'b';
  static const _typeDouble = 'd';
  static const _typeList = 'l';
  static const _typeMap = 'm';

  String _encodeEnvelope(String type, dynamic value) {
    return jsonEncode({'t': type, 'v': value});
  }

  Object? _decodeEnvelope(String encoded) {
    try {
      final obj = jsonDecode(encoded) as Map<String, dynamic>?;
      if (obj == null || !obj.containsKey('v')) return null;
      return obj['v'];
    } catch (_) {
      return null;
    }
  }

  bool _isEnvelope(String? s) => s != null && s.startsWith(_envelopePrefix);

  @override
  String? getToken() => _memoryToken;

  @override
  Future<void> saveToken(String token) async {
    try {
      final encoded = _encodeEnvelope(_typeString, token);
      await _secureStorage.write(_tokenKey, encoded);
      _store[_tokenKey] = encoded;
      _memoryToken = token;
    } catch (e) {
      _log.e('Failed to save token: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(_tokenKey);
      _store.remove(_tokenKey);
      _memoryToken = null;
    } catch (e) {
      _log.e('Failed to delete token: $e');
    }
  }

  @override
  Map<String, dynamic>? getUserData() => _memoryUserData;

  @override
  Future<void> saveUserData(Map<String, dynamic> json) async {
    try {
      final encoded = _encodeEnvelope(_typeMap, json);
      await _secureStorage.write(_userKey, encoded);
      _store[_userKey] = encoded;
      _memoryUserData = json;
    } catch (e) {
      _log.e('Failed to save user data: $e');
      rethrow;
    }
  }

  Object? _getFromStore(String key) {
    final raw = _store[key];
    if (raw == null) return null;
    if (_isEnvelope(raw)) return _decodeEnvelope(raw);
    return raw;
  }

  @override
  Object? getFromLocalCache(String key) {
    if (key == _tokenKey) return _memoryToken;
    if (key == _userKey) {
      return _memoryUserData != null ? jsonEncode(_memoryUserData) : null;
    }
    try {
      return _getFromStore(key);
    } catch (e) {
      _log.e('Failed to get value for key "$key": $e');
      return null;
    }
  }

  String _encodeValue(dynamic value) {
    if (value is String) return _encodeEnvelope(_typeString, value);
    if (value is bool) return _encodeEnvelope(_typeBool, value);
    if (value is int) return _encodeEnvelope(_typeInt, value);
    if (value is double) return _encodeEnvelope(_typeDouble, value);
    if (value is List<String>) return _encodeEnvelope(_typeList, value);
    if (value is Map || value is List<Map>) {
      return _encodeEnvelope(_typeMap, value);
    }
    throw ArgumentError('Unsupported value type: ${value.runtimeType}');
  }

  @override
  Future<void> saveToLocalCache({
    required String key,
    required dynamic value,
  }) async {
    final isSensitiveKey = key.toLowerCase().contains('token') ||
        key.toLowerCase().contains('password') ||
        key.toLowerCase().contains('secret');
    if (isSensitiveKey) {
      _log.i('Saving data: key="$key", type="${value.runtimeType}"');
    } else {
      _log.i(
          'Saving data: key="$key", value="$value", type="${value.runtimeType}"');
    }

    if (key == _tokenKey && value is String) {
      await saveToken(value);
      return;
    }
    if (key == _userKey && value is Map<String, dynamic>) {
      await saveUserData(value);
      return;
    }

    try {
      final encoded = _encodeValue(value);
      await _secureStorage.write(key, encoded);
      _store[key] = encoded;
    } catch (e) {
      _log.e('Failed to save value for key "$key": $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    if (key == _tokenKey) {
      await deleteToken();
      return;
    }
    if (key == _userKey) {
      try {
        await _secureStorage.delete(_userKey);
        _store.remove(_userKey);
        _memoryUserData = null;
      } catch (e) {
        _log.e('Failed to remove user data: $e');
      }
      return;
    }
    try {
      await _secureStorage.delete(key);
      _store.remove(key);
    } catch (e) {
      _log.e('Failed to remove value for key "$key": $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final keys = List<String>.from(_store.keys);
      for (final key in keys) {
        await _secureStorage.delete(key);
      }
      _store.clear();
      _memoryToken = null;
      _memoryUserData = null;
    } catch (e) {
      _log.e('Failed to clear cache: $e');
      rethrow;
    }
  }

  @override
  Map? getMapData(String key) {
    try {
      final data = getFromLocalCache(key);
      if (data is String) {
        final decoded = jsonDecode(data);
        return decoded is Map ? decoded : null;
      }
      if (data is Map) return data;
      return null;
    } catch (e) {
      _log.e('Failed to get map data for key "$key": $e');
      return null;
    }
  }
}
