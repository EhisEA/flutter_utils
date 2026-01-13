import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils/extensions/date_extension.dart';

void main() {
  group('DateExtension', () {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));

    group('isToday', () {
      test('should return true for today', () {
        expect(today.isToday, isTrue);
      });

      test('should return false for yesterday', () {
        expect(yesterday.isToday, isFalse);
      });

      test('should return false for tomorrow', () {
        expect(tomorrow.isToday, isFalse);
      });

      test('should return false for null', () {
        DateTime? nullDate;
        expect(nullDate.isToday, isFalse);
      });
    });

    group('isYesterday', () {
      test('should return true for yesterday', () {
        expect(yesterday.isYesterday, isTrue);
      });

      test('should return false for today', () {
        expect(today.isYesterday, isFalse);
      });

      test('should return false for tomorrow', () {
        expect(tomorrow.isYesterday, isFalse);
      });

      test('should return false for null', () {
        DateTime? nullDate;
        expect(nullDate.isYesterday, isFalse);
      });
    });

    group('isTomorrow', () {
      test('should return true for tomorrow', () {
        expect(tomorrow.isTomorrow, isTrue);
      });

      test('should return false for today', () {
        expect(today.isTomorrow, isFalse);
      });

      test('should return false for yesterday', () {
        expect(yesterday.isTomorrow, isFalse);
      });

      test('should return false for null', () {
        DateTime? nullDate;
        expect(nullDate.isTomorrow, isFalse);
      });
    });

    group('isSameDayAs', () {
      test('should return true for same day', () {
        final date1 = DateTime(2024, 1, 15, 10, 30);
        final date2 = DateTime(2024, 1, 15, 20, 45);
        expect(date1.isSameDayAs(date2), isTrue);
      });

      test('should return false for different days', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 1, 16);
        expect(date1.isSameDayAs(date2), isFalse);
      });

      test('should return false for null', () {
        DateTime? nullDate;
        expect(nullDate.isSameDayAs(today), isFalse);
        expect(today.isSameDayAs(null), isFalse);
      });
    });

    group('format', () {
      test('should format date with pattern', () {
        final date = DateTime(2024, 1, 15);
        final formatted = date.format('yyyy-MM-dd');
        expect(formatted, contains('2024-01-15'));
      });

      test('should return empty string for null', () {
        DateTime? nullDate;
        expect(nullDate.format('yyyy-MM-dd'), equals(''));
      });
    });

    group('toServerTime', () {
      test('should return date in yyyy-MM-dd format', () {
        final date = DateTime(2024, 1, 15);
        expect(date.toServerTime, equals('2024-01-15'));
      });

      test('should return empty string for null', () {
        DateTime? nullDate;
        expect(nullDate.toServerTime, equals(''));
      });
    });

    group('dateYMD', () {
      test('should return date in yyyy-MM-dd format', () {
        final date = DateTime(2024, 1, 15);
        expect(date.dateYMD, equals('2024-01-15'));
      });

      test('should return null for null date', () {
        DateTime? nullDate;
        expect(nullDate.dateYMD, isNull);
      });
    });

    group('ddmmyyyy', () {
      test('should return date in dd/MM/yyyy format', () {
        final date = DateTime(2024, 1, 15);
        expect(date.ddmmyyyy, equals('15/01/2024'));
      });

      test('should return empty string for null', () {
        DateTime? nullDate;
        expect(nullDate.ddmmyyyy, equals(''));
      });
    });

    group('appDateDisplay', () {
      test('should return "Today" for today', () {
        expect(today.appDateDisplay, equals('Today'));
      });

      test('should return "Yesterday" for yesterday', () {
        expect(yesterday.appDateDisplay, equals('Yesterday'));
      });

      test('should return "Tomorrow" for tomorrow', () {
        expect(tomorrow.appDateDisplay, equals('Tomorrow'));
      });

      test('should return formatted date for other dates', () {
        final date = DateTime(2024, 1, 15);
        final display = date.appDateDisplay;
        expect(display, contains('15'));
        expect(display, contains('2024'));
      });

      test('should return empty string for null', () {
        DateTime? nullDate;
        expect(nullDate.appDateDisplay, equals(''));
      });
    });
  });
}

