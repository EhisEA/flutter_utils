import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Utility class providing static methods for formatting currency and numbers.
class CurrencyFormatters {
  /// Formats a monetary value without currency symbol.
  /// [money] - The amount to format.
  /// Returns formatted string with thousands separators and 2 decimal places.
  static String moneyFormatWithoutCurrency(double money) {
    if (money.isNegative) {
      throw ArgumentError('Money value cannot be negative');
    }

    // Define format pattern with thousands separators and 2 decimal places
    final moneyFormat = NumberFormat('#,###,###,###.00', 'en_US');
    if (money == 0.0) return "0.00";
    String moneyFormatted = moneyFormat.format(money);

    // Handle values less than 1 to display properly (e.g. 0.90 instead of .90)
    if (money > 0 && money < 1) return moneyFormatted.replaceRange(0, 2, "0");
    return moneyFormatted;
  }
}

/// Formats numbers with thousands separators and optional decimal places
/// Supports currency symbol customization and localization
class ThousandsFormatter extends NumberInputFormatter {
  // Default decimal number formatter
  static final NumberFormat _formatter = NumberFormat.decimalPattern();

  // Input filtering and validation components
  final FilteringTextInputFormatter _decimalFormatter;
  final String _decimalSeparator;
  final RegExp _decimalRegex;

  // Customization options
  final NumberFormat? formatter;
  final bool allowFraction;
  final String currencySymbol;
  final bool currencySymbolBefore;

  /// Constructor with customization options
  ThousandsFormatter({
    this.formatter,
    this.allowFraction = false,
    this.currencySymbol = '\$',
    this.currencySymbolBefore = true,
  })  : _decimalSeparator = (formatter ?? _formatter).symbols.DECIMAL_SEP,
        _decimalRegex = RegExp(
            allowFraction ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?' : r'\d+'),
        _decimalFormatter = FilteringTextInputFormatter.allow(RegExp(allowFraction
            ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?'
            : r'\d+'));

  @override
  String _formatPattern(String? digits) {
    if (digits == null || digits.isEmpty) return '';

    // Convert input to numeric value
    num number;
    if (allowFraction) {
      String decimalDigits = digits;
      if (_decimalSeparator != '.') {
        decimalDigits = digits.replaceFirst(RegExp(_decimalSeparator), '.');
      }
      number = double.tryParse(decimalDigits) ?? 0.0;
    } else {
      number = int.tryParse(digits) ?? 0;
    }

    // Apply formatting
    final result = (formatter ?? _formatter).format(number);
    if (allowFraction && digits.endsWith(_decimalSeparator)) {
      return '$result$_decimalSeparator';
    }
    return currencySymbolBefore ? "$currencySymbol $result" : "$result $currencySymbol";
  }

  @override
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue) {
    return _decimalFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool _isUserInput(String s) {
    return s == _decimalSeparator || _decimalRegex.firstMatch(s) != null;
  }
}

/// Formats input text as credit card numbers with customizable separator
/// Default format: XXXX XXXX XXXX XXXX
class CreditCardFormatter extends NumberInputFormatter {
  // Regex for digit-only validation
  static final RegExp _digitOnlyRegex = RegExp(r'\d+');
  static final FilteringTextInputFormatter _digitOnlyFormatter =
      FilteringTextInputFormatter.allow(_digitOnlyRegex);

  final String separator;

  CreditCardFormatter({this.separator = ' '});

  @override
  String _formatPattern(String digits) {
    StringBuffer buffer = StringBuffer();
    int offset = 0;
    int count = min(4, digits.length);
    final length = digits.length;

    // Group digits in sets of 4
    for (; count <= length; count += min(4, max(1, length - count))) {
      buffer.write(digits.substring(offset, count));
      if (count < length) {
        buffer.write(separator);
      }
      offset = count;
    }
    return buffer.toString();
  }

  @override
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue) {
    return _digitOnlyFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool _isUserInput(String s) {
    return _digitOnlyRegex.firstMatch(s) != null;
  }
}

/// Base formatter class for handling numeric input with formatting
abstract class NumberInputFormatter extends TextInputFormatter {
  NumberInputFormatter();

  TextEditingValue? _lastNewValue;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Skip processing if text hasn't changed
    if (newValue.text == _lastNewValue?.text) {
      return newValue;
    }
    _lastNewValue = newValue;

    // Apply formatting and handle cursor position
    newValue = _formatValue(oldValue, newValue);
    int selectionIndex = newValue.selection.end;
    final newText = _formatPattern(newValue.text);

    // Track inserted formatting characters
    int insertCount = 0;
    int inputCount = 0;
    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    // Adjust cursor position
    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    // Handle cursor position after formatting characters
    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selectionIndex),
        composing: TextRange.empty);
  }

  /// Validates if character is from user input
  bool _isUserInput(String s);

  /// Applies formatting pattern to input
  String _formatPattern(String digits);

  /// Validates and filters input
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue);
}

/// Input formatter that prevents leading zeros
class NoInitialZeroInputFormatter extends TextInputFormatter {
  const NoInitialZeroInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith('0')) {
      return oldValue;
    }
    return newValue;
  }
}
