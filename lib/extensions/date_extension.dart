import 'package:intl/intl.dart';

extension DateExtension on DateTime? {
  /// Formats the date using the given [formatPattern].
  /// If [addDayExtension] is true, adds a suffix to the day (e.g., 1st, 2nd).
  String format(String formatPattern, {bool addDayExtension = true}) {
    if (this == null) return '';
    return (DateFormat(formatPattern).format(this!))
        .replaceAll(",", addDayExtension ? '${_addDaySuffix(this!.day)},' : "");
  }

  /// Adds a suffix to the day (e.g., 1st, 2nd, 3rd, 4th).
  String _addDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// Returns a human-readable time ago string (e.g., "Yesterday", "hh:mm aa").
  String get chatTimeAgo {
    if (this == null) return '';
    if (isToday) return DateFormat('hh:mm aa').format(this!).toLowerCase();
    if (isYesterday) return 'Yesterday';
    return DateFormat('MM/dd/yyyy').format(this!);
  }

  /// Returns a formatted date separator for chat (e.g., "Mon, 23 Oct, 2023").
  String get chatDateSeparator {
    return DateFormat('EEE, dd MMM, yyyy').format(this!);
  }

  /// Returns a display-friendly date string (e.g., "Today", "Yesterday").
  String get appDateDisplay {
    if (this == null) return '';
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    if (isTomorrow) return 'Tomorrow';
    return DateFormat('dd MMM, yyyy').format(this!);
  }

  /// Returns the time in "hh:mm aa" format (e.g., "01:29 AM").
  String get toMessageTime {
    if (this == null) return '';
    return DateFormat('hh:mm aa').format(this!).toLowerCase();
  }

  /// Returns the date in "yyyy-MM-dd" format for server communication.
  String get toServerTime {
    if (this == null) return '';
    return DateFormat('yyyy-MM-dd').format(this!);
  }

  /// Checks if the date is within the current minute.
  bool get isNow {
    if (this == null) return false;
    final now = DateTime.now();
    return this?.year == now.year &&
        this?.month == now.month &&
        this?.day == now.day &&
        this?.hour == now.hour &&
        this?.minute == now.minute;
  }

  /// Checks if the date is today.
  bool get isToday {
    if (this == null) return false;
    final now = DateTime.now();
    return this?.year == now.year && this?.month == now.month && this?.day == now.day;
  }

  /// Checks if the date is the same day as [date].
  bool isSameDayAs([DateTime? date]) {
    if (this == null || date == null) return false;
    return this?.year == date.year && this?.month == date.month && this?.day == date.day;
  }

  /// Checks if the date is tomorrow.
  bool get isTomorrow {
    if (this == null) return false;
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return this?.year == tomorrow.year &&
        this?.month == tomorrow.month &&
        this?.day == tomorrow.day;
  }

  /// Checks if the date was yesterday.
  bool get isYesterday {
    if (this == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return this?.year == yesterday.year &&
        this?.month == yesterday.month &&
        this?.day == yesterday.day;
  }

  /// Returns the date in "yyyy-MM-dd" format.
  String? get dateYMD => this == null ? null : DateFormat('yyyy-MM-dd').format(this!);

  /// Returns the time in "HH:mm:ss'Z'" format.
  String? get timeHMSZ => this == null ? null : DateFormat("HH:mm:ss'Z'").format(this!);

  /// Returns the time in "hh:mm aa" format (e.g., "01:29 AM").
  String get timeHMA => this == null ? '' : DateFormat('hh:mm aa').format(this!);

  /// Returns the time in "HH:mm" format (e.g., "13:29").
  String get timeHM => this == null ? '' : DateFormat('HH:mm').format(this!);

  /// Returns the date in "dd MMMM, yyyy" format (e.g., "23 October, 2023").
  String get dateDMY => this == null ? '' : DateFormat('dd MMMM, yyyy').format(this!);

  /// Returns the date in "dd/MM/yyyy" format (e.g., "23/10/2023").
  String get ddmmyyyy => this == null ? '' : DateFormat('dd/MM/yyyy').format(this!);
}
