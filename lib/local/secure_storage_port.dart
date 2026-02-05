/// Port for secure key-value storage (e.g. Keychain, KeyStore).
/// Allows injecting a test double in tests.
abstract class SecureStoragePort {
  Future<String?> read(String key);
  Future<Map<String, String>> readAll();
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}
