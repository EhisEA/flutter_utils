import 'dart:convert';

import 'local_cache.dart';

class LocalCacheTestImpl implements LocalCache {
  final Map<String, dynamic> _cache = {};
  static const _tokenKey = 'userToken';
  static const _userDataKey = 'userData';

  @override
  Future<void> clearCache() async {
    _cache.clear();
  }

  @override
  Future<void> deleteToken() async {
    _cache.remove(_tokenKey);
  }

  @override
  Object? getFromLocalCache(String key) {
    return _cache[key];
  }

  @override
  String? getToken() {
    return _cache[_tokenKey] as String?;
  }

  @override
  Map<String, dynamic>? getUserData() {
    final data = _cache[_userDataKey];
    if (data == null) return null;
    return json.decode(data.toString()) as Map<String, dynamic>;
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    _cache.remove(key);
  }

  @override
  Future<void> saveToken(String token) async {
    _cache[_tokenKey] = token;
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    if (value is Map || value is List<Map>) {
      _cache[key] = json.encode(value);
    } else {
      _cache[key] = value;
    }
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> json) async {
    _cache[_userDataKey] = jsonEncode(json);
  }
}
