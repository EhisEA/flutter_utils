import 'package:flutter_utils/local/secure_storage_port.dart';

/// In-memory [SecureStoragePort] for testing.
class FakeSecureStorage implements SecureStoragePort {
  final Map<String, String> _store = {};

  @override
  Future<String?> read(String key) async => _store[key];

  @override
  Future<Map<String, String>> readAll() async =>
      Map<String, String>.from(_store);

  @override
  Future<void> write(String key, String value) async {
    _store[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  void clear() => _store.clear();
}
