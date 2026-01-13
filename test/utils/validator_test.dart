import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils/utils/validators.dart';

void main() {
  group('Validator', () {
    group('email', () {
      test('should return null for valid email', () {
        expect(Validator.email('user@example.com'), isNull);
        expect(Validator.email('test.email+tag@domain.co.uk'), isNull);
        expect(Validator.email('user123@test-domain.org'), isNull);
      });

      test('should return error message for invalid email', () {
        expect(Validator.email(null), isNotNull);
        expect(Validator.email(''), isNotNull);
        expect(Validator.email('invalid-email'), isNotNull);
        expect(Validator.email('user@'), isNotNull);
        expect(Validator.email('@domain.com'), isNotNull);
      });
    });

    group('password', () {
      test('should return null for valid password', () {
        expect(Validator.password('MyPass123!'), isNull);
        expect(Validator.password('SecureP@ss1', limit: 8), isNull);
        expect(Validator.password('Strong#Pass2'), isNull);
      });

      test('should return error message for invalid password', () {
        expect(Validator.password(null), isNotNull);
        expect(Validator.password(''), isNotNull);
        expect(Validator.password('weak'), isNotNull);
        expect(Validator.password('NoSpecialChar123'), isNotNull);
        expect(Validator.password('NoNumber!'), isNotNull);
        expect(Validator.password('nouppercase123!'), isNotNull);
        expect(Validator.password('NOLOWERCASE123!'), isNotNull);
      });

      test('should respect custom limit', () {
        expect(Validator.password('Pass1!', limit: 5), isNull);
        expect(Validator.password('Pass1!', limit: 10), isNotNull);
      });
    });

    group('phone', () {
      test('should return null for valid phone', () {
        expect(Validator.phone('+1234567890'), isNull);
        expect(Validator.phone('(123) 456-7890'), isNull);
        expect(Validator.phone('123-456-7890'), isNull);
        expect(Validator.phone('123.456.7890'), isNull);
      });

      test('should return error message for invalid phone', () {
        expect(Validator.phone(null), isNotNull);
        expect(Validator.phone(''), isNotNull);
        expect(Validator.phone('123'), isNotNull);
        expect(Validator.phone('not-a-phone'), isNotNull);
      });

      test('should use custom title in error message', () {
        final error = Validator.phone('', 'Mobile Number');
        expect(error, contains('Mobile Number'));
      });
    });

    group('otpCode', () {
      test('should return null for valid OTP', () {
        expect(Validator.otpCode('123456'), isNull);
        expect(Validator.otpCode('000000'), isNull);
      });

      test('should return error message for invalid OTP', () {
        expect(Validator.otpCode(null), isNotNull);
        expect(Validator.otpCode(''), isNotNull);
        expect(Validator.otpCode('   '), isNotNull);
        expect(Validator.otpCode('12345'), isNotNull);
        expect(Validator.otpCode('abc123'), isNotNull);
      });
    });

    group('name', () {
      test('should return null for valid name', () {
        expect(Validator.name('John'), isNull);
        expect(Validator.name('Mary Jane'), isNull);
        expect(Validator.name('Jean-Pierre'), isNull);
      });

      test('should return error message for invalid name', () {
        expect(Validator.name(null), isNotNull);
        expect(Validator.name(''), isNotNull);
        expect(Validator.name('A'), isNotNull);
        expect(Validator.name('  '), isNotNull);
      });
    });

    group('emptyField', () {
      test('should return null for non-empty field', () {
        expect(Validator.emptyField('value'), isNull);
        expect(Validator.emptyField('  value  '), isNull);
      });

      test('should return error message for empty field', () {
        expect(Validator.emptyField(null), isNotNull);
        expect(Validator.emptyField(''), isNotNull);
        expect(Validator.emptyField('   '), isNotNull);
      });

      test('should use custom title in error message', () {
        final error = Validator.emptyField('', 'Username');
        expect(error, contains('Username'));
      });
    });

    group('username', () {
      test('should return null for valid username', () {
        expect(Validator.username('john_doe'), isNull);
        expect(Validator.username('user123'), isNull);
      });

      test('should return error message for invalid username', () {
        expect(Validator.username(null), isNotNull);
        expect(Validator.username(''), isNotNull);
        expect(Validator.username('   '), isNotNull);
      });

      test('should respect custom limit', () {
        expect(Validator.username('short', limit: 10), isNull);
        expect(Validator.username('this_is_too_long_username', limit: 10), isNotNull);
      });
    });

    group('singleName', () {
      test('should return null for valid single name', () {
        expect(Validator.singleName('John'), isNull);
        expect(Validator.singleName('Mary'), isNull);
      });

      test('should return error message for invalid single name', () {
        expect(Validator.singleName(null), isNotNull);
        expect(Validator.singleName(''), isNotNull);
        expect(Validator.singleName('   '), isNotNull);
      });
    });

    group('fullname', () {
      test('should return null for valid full name', () {
        expect(Validator.fullname('John Doe'), isNull);
        expect(Validator.fullname('Mary Jane Watson'), isNull);
        expect(Validator.fullname('Jean Pierre', nameLimit: 10), isNull);
      });

      test('should return error message for invalid full name', () {
        expect(Validator.fullname(null), isNotNull);
        expect(Validator.fullname(''), isNotNull);
        expect(Validator.fullname('John'), isNotNull);
        expect(Validator.fullname('A B'), isNotNull);
        expect(Validator.fullname('Jo Do', nameLimit: 5), isNotNull);
      });
    });
  });
}


