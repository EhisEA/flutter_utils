import 'package:intl/intl.dart';

extension NumUtils on num {
  /// Formats the number as a currency value with optional decimal places.
  String toCurrency({int decimalDigits = 2, String symbol = ''}) {
    final format = NumberFormat('#,##0.${'0' * decimalDigits}', 'en_US');
    return '$symbol${format.format(this)}';
  }

  /// Formats the number as a whole number (no decimal places).
  String toCurrencyWholeNumber({String symbol = ''}) {
    final format = NumberFormat('#,##0', 'en_US');
    return '$symbol${format.format(this)}';
  }

  /// Formats the number as a decimal number (only decimal places).
  String toCurrencyDecimalNumber({String symbol = ''}) {
    final format = NumberFormat('0.00', 'en_US');
    return '$symbol${format.format(this)}';
  }

  /// Returns "Free" if the amount is zero.
  String toCurrencyOrFree({String symbol = '₦'}) {
    return this == 0 ? 'Free' : toCurrency(symbol: symbol);
  }

  /// Abbreviates the number with suffixes (k, M, B).
  String abbreviate({int decimalDigits = 1}) {
    if (this < 1000) return toStringAsFixed(decimalDigits);
    if (this < 1000000) return '${(this / 1000).toStringAsFixed(decimalDigits)}k';
    if (this < 1000000000) return '${(this / 1000000).toStringAsFixed(decimalDigits)}M';
    return '${(this / 1000000000).toStringAsFixed(decimalDigits)}B';
  }

  /// Formats the number as a countdown timer (e.g., MM:SS).
  String get countdownFormat {
    final minutes = (this / 60).floor().toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Formats the number as a percentage.
  String toPercentage({int decimalDigits = 0}) {
    final format = NumberFormat.decimalPercentPattern(decimalDigits: decimalDigits);
    return format.format(this / 100);
  }

  /// Formats the number as a file size (e.g., KB, MB, GB).
  String toFileSize({int decimalDigits = 2}) {
    if (this < 1024) return '${toStringAsFixed(decimalDigits)} B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(decimalDigits)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(decimalDigits)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(decimalDigits)} GB';
  }

  /// Checks if the number is positive.
  bool get isPositive => this > 0;

  /// Checks if the number is negative.
  bool get isNegative => this < 0;

  /// Checks if the number is within a range [min, max].
  bool isBetween(num min, num max) => this >= min && this <= max;
}
