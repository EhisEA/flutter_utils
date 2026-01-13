import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils/local/local_cache_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalCacheImpl', () {
    late LocalCacheImpl cache;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      cache = LocalCacheImpl(sharedPreferences: prefs);
    });

    tearDown(() async {
      await prefs.clear();
    });

    group('Token operations', () {
      test('should save and retrieve token', () async {
        const token = 'test-token-123';
        await cache.saveToken(token);
        expect(cache.getToken(), equals(token));
      });

      test('should delete token', () async {
        await cache.saveToken('test-token');
        await cache.deleteToken();
        expect(cache.getToken(), isNull);
      });

      test('should return null when token does not exist', () {
        expect(cache.getToken(), isNull);
      });
    });

    group('Generic cache operations', () {
      test('should save and retrieve string value', () async {
        await cache.saveToLocalCache(key: 'test-key', value: 'test-value');
        expect(cache.getFromLocalCache('test-key'), equals('test-value'));
      });

      test('should save and retrieve int value', () async {
        await cache.saveToLocalCache(key: 'int-key', value: 42);
        expect(cache.getFromLocalCache('int-key'), equals(42));
      });

      test('should save and retrieve bool value', () async {
        await cache.saveToLocalCache(key: 'bool-key', value: true);
        expect(cache.getFromLocalCache('bool-key'), equals(true));
      });

      test('should save and retrieve double value', () async {
        await cache.saveToLocalCache(key: 'double-key', value: 3.14);
        expect(cache.getFromLocalCache('double-key'), equals(3.14));
      });

      test('should save and retrieve list of strings', () async {
        final list = ['item1', 'item2', 'item3'];
        await cache.saveToLocalCache(key: 'list-key', value: list);
        expect(cache.getFromLocalCache('list-key'), equals(list));
      });

      test('should save and retrieve map', () async {
        final map = {'key1': 'value1', 'key2': 'value2'};
        await cache.saveToLocalCache(key: 'map-key', value: map);
        final retrieved = cache.getFromLocalCache('map-key');
        expect(retrieved, isNotNull);
      });

      test('should remove value from cache', () async {
        await cache.saveToLocalCache(key: 'remove-key', value: 'value');
        await cache.removeFromLocalCache('remove-key');
        expect(cache.getFromLocalCache('remove-key'), isNull);
      });

      test('should clear all cache', () async {
        await cache.saveToLocalCache(key: 'key1', value: 'value1');
        await cache.saveToLocalCache(key: 'key2', value: 'value2');
        await cache.clearCache();
        expect(cache.getFromLocalCache('key1'), isNull);
        expect(cache.getFromLocalCache('key2'), isNull);
      });

      test('should return null for non-existent key', () {
        expect(cache.getFromLocalCache('non-existent'), isNull);
      });
    });

    group('User data operations', () {
      test('should save and retrieve user data', () async {
        final userData = {
          'id': '123',
          'name': 'John Doe',
          'email': 'john@example.com',
        };
        await cache.saveUserData(userData);
        final retrieved = cache.getUserData();
        expect(retrieved, isNotNull);
        expect(retrieved!['id'], equals('123'));
        expect(retrieved['name'], equals('John Doe'));
      });

      test('should return null when user data does not exist', () {
        expect(cache.getUserData(), isNull);
      });
    });

    group('Map data operations', () {
      test('should save and retrieve map data', () async {
        final mapData = {'key1': 'value1', 'key2': 42};
        await cache.saveToLocalCache(key: 'map-data', value: mapData);
        final retrieved = cache.getMapData('map-data');
        expect(retrieved, isNotNull);
        expect(retrieved is Map, isTrue);
      });

      test('should return null when map data does not exist', () {
        expect(cache.getMapData('non-existent'), isNull);
      });
    });

    group('Error handling', () {
      test('should handle unsupported value type gracefully', () async {
        expect(
          () => cache.saveToLocalCache(key: 'unsupported', value: Object()),
          throwsArgumentError,
        );
      });
    });
  });
}


