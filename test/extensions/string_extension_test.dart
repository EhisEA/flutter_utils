import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils/extensions/string_extension.dart';

void main() {
  group('StringExtension', () {
    group('isEmail', () {
      test('should return true for valid email addresses', () {
        expect('user@example.com'.isEmail, isTrue);
        expect('test.email+tag@domain.co.uk'.isEmail, isTrue);
        expect('user123@test-domain.org'.isEmail, isTrue);
      });

      test('should return false for invalid email addresses', () {
        expect('invalid-email'.isEmail, isFalse);
        expect('user@'.isEmail, isFalse);
        expect('@domain.com'.isEmail, isFalse);
        expect('user@domain'.isEmail, isFalse);
        expect(''.isEmail, isFalse);
      });
    });

    group('isLink', () {
      test('should return true for valid URLs', () {
        expect('https://flutter.dev'.isLink, isTrue);
        expect('http://example.com'.isLink, isTrue);
        expect('www.google.com'.isLink, isTrue);
        expect('https://example.com/path?param=value'.isLink, isTrue);
      });

      test('should return false for invalid URLs', () {
        expect('not-a-url'.isLink, isFalse);
        expect('ftp://example.com'.isLink, isFalse);
        expect(''.isLink, isFalse);
      });
    });

    group('capitalizeFirstLetter', () {
      test('should capitalize first letter and lowercase rest by default', () {
        expect('hello world'.capitalizeFirstLetter(), equals('Hello world'));
        expect('HELLO WORLD'.capitalizeFirstLetter(), equals('Hello world'));
      });

      test('should capitalize first letter only when lowercaseOther is false', () {
        expect('hello world'.capitalizeFirstLetter(lowercaseOther: false), equals('Hello world'));
        expect('HELLO WORLD'.capitalizeFirstLetter(lowercaseOther: false), equals('HHELLO WORLD'));
      });

      test('should handle empty string', () {
        expect(''.capitalizeFirstLetter(), equals(''));
      });
    });

    group('toCurrencyFormat', () {
      test('should format valid numbers as currency', () {
        expect('1234.56'.toCurrencyFormat(), equals('1,234.56'));
        expect('1000'.toCurrencyFormat(), equals('1,000.0'));
        expect('0.99'.toCurrencyFormat(), equals('0.99'));
      });

      test('should handle invalid numbers', () {
        expect('invalid'.toCurrencyFormat(), equals('0.0'));
        expect(''.toCurrencyFormat(), equals('0.0'));
      });
    });

    group('isImage', () {
      test('should return true for image file extensions', () {
        expect('photo.jpg'.isImage, isTrue);
        expect('image.png'.isImage, isTrue);
        expect('picture.jpeg'.isImage, isTrue);
        expect('photo.heic'.isImage, isTrue);
        expect('animation.gif'.isImage, isTrue);
      });

      test('should return false for non-image extensions', () {
        expect('document.pdf'.isImage, isFalse);
        expect('video.mp4'.isImage, isFalse);
        expect('file.txt'.isImage, isFalse);
        expect(''.isImage, isFalse);
      });
    });

    group('isDocument', () {
      test('should return true for document file extensions', () {
        expect('document.pdf'.isDocument, isTrue);
        expect('report.doc'.isDocument, isTrue);
        expect('presentation.docx'.isDocument, isTrue);
      });

      test('should return false for non-document extensions', () {
        expect('photo.jpg'.isDocument, isFalse);
        expect('video.mp4'.isDocument, isFalse);
        expect(''.isDocument, isFalse);
      });
    });

    group('isAudio', () {
      test('should return true for audio file extensions', () {
        expect('song.mp3'.isAudio, isTrue);
      });

      test('should return false for non-audio extensions', () {
        expect('video.mp4'.isAudio, isFalse);
        expect('photo.jpg'.isAudio, isFalse);
        expect(''.isAudio, isFalse);
      });
    });

    group('isVideo', () {
      test('should return true for video file extensions', () {
        expect('movie.mp4'.isVideo, isTrue);
        expect('clip.mov'.isVideo, isTrue);
      });

      test('should return false for non-video extensions', () {
        expect('song.mp3'.isVideo, isFalse);
        expect('photo.jpg'.isVideo, isFalse);
        expect(''.isVideo, isFalse);
      });
    });

    group('initials', () {
      test('should extract initials from names', () {
        expect('John Doe'.initials, equals('JD'));
        expect('Mary Jane Watson'.initials, equals('MJW'));
        expect('A B C'.initials, equals('ABC'));
      });

      test('should handle edge cases', () {
        expect(''.initials, equals(''));
        expect('John'.initials, equals('J'));
        expect('  John  Doe  '.initials, equals('JD'));
      });
    });

    group('nullIfEmpty', () {
      test('should return null for empty string', () {
        expect(''.nullIfEmpty, isNull);
        expect('   '.nullIfEmpty, isNull);
      });

      test('should return string for non-empty string', () {
        expect('hello'.nullIfEmpty, equals('hello'));
        expect('  hello  '.nullIfEmpty, equals('  hello  '));
      });
    });

    group('withSuffix', () {
      test('should add suffix to non-empty string', () {
        expect('hello'.withSuffix(' world'), equals('hello world'));
        expect('test'.withSuffix('.txt'), equals('test.txt'));
      });

      test('should return null for empty string', () {
        expect(''.withSuffix('suffix'), isNull);
        expect('   '.withSuffix('suffix'), isNull);
      });
    });

    group('withPrefix', () {
      test('should add prefix to non-empty string', () {
        expect('world'.withPrefix('hello '), equals('hello world'));
        expect('file.txt'.withPrefix('/path/'), equals('/path/file.txt'));
      });

      test('should return null for empty string', () {
        expect(''.withPrefix('prefix'), isNull);
        expect('   '.withPrefix('prefix'), isNull);
      });
    });

    group('toTitleCase', () {
      test('should convert string to title case', () {
        expect('hello world'.toTitleCase(), equals('Hello World'));
        expect('HELLO WORLD'.toTitleCase(), equals('Hello World'));
        expect('hello WORLD test'.toTitleCase(), equals('Hello World Test'));
      });

      test('should handle edge cases', () {
        expect(''.toTitleCase(), equals(''));
        expect('hello'.toTitleCase(), equals('Hello'));
        expect('  hello  world  '.toTitleCase(), equals('  Hello  World  '));
      });
    });

    group('toSlug', () {
      test('should convert string to slug format', () {
        expect('Hello World'.toSlug(), equals('hello-world'));
        expect('This is a Test!'.toSlug(), equals('this-is-a-test'));
        expect('Special@#\$%Characters'.toSlug(), equals('special-characters'));
      });

      test('should handle edge cases', () {
        expect(''.toSlug(), equals(''));
        expect('   '.toSlug(), equals('-'));
        expect('---test---'.toSlug(), equals('-test-'));
      });
    });

    group('isPhoneNumber', () {
      test('should return true for valid phone numbers', () {
        expect('+1234567890'.isPhoneNumber, isTrue);
        expect('(123) 456-7890'.isPhoneNumber, isTrue);
        expect('123-456-7890'.isPhoneNumber, isTrue);
        expect('123.456.7890'.isPhoneNumber, isTrue);
        expect('1234567890'.isPhoneNumber, isTrue);
      });

      test('should return false for invalid phone numbers', () {
        expect('not-a-phone'.isPhoneNumber, isFalse);
        expect('123'.isPhoneNumber, isFalse);
        expect(''.isPhoneNumber, isFalse);
      });
    });

    group('isStrongPassword', () {
      test('should return true for strong passwords', () {
        expect('MyPass123!'.isStrongPassword, isTrue);
        expect('SecureP@ss1'.isStrongPassword, isTrue);
        expect('Strong#Pass2'.isStrongPassword, isTrue);
      });

      test('should return false for weak passwords', () {
        expect('password'.isStrongPassword, isFalse);
        expect('12345678'.isStrongPassword, isFalse);
        expect('Password'.isStrongPassword, isFalse);
        expect('password123'.isStrongPassword, isFalse);
        expect('PASSWORD123!'.isStrongPassword, isFalse);
        expect(''.isStrongPassword, isFalse);
      });
    });
  });
} 