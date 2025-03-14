import 'dart:developer';

// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m

class LoggerColor {
  static const black = "\x1B[30m";
  static const red = "\x1B[31m";
  static const green = "\x1B[32m";
  static const yellow = "\x1B[33m";
  static const blue = "\x1B[34m";
  static const magenta = "\x1B[35m";
  static const cyan = "\x1B[36m";
  static const white = "\x1B[37m";
  static const lightGrey = "\x1B[37;1m";
  static const darkGrey = "\x1B[90m";
  static const reset = "\x1B[0m";
}

class AppLogger {
  final Type type;

  const AppLogger(this.type);

  /// Log a message at level [Level.verbose].
  void v(dynamic message, {dynamic error, StackTrace? stackTrace, String? functionName}) {
    _log(
      message,
      color: LoggerColor.magenta,
      error: error,
      stackTrace: stackTrace,
      functionName: functionName,
    );
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, {dynamic error, StackTrace? stackTrace, String? functionName}) {
    _log(
      message,
      color: LoggerColor.green,
      error: error,
      stackTrace: stackTrace,
      functionName: functionName,
    );
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, {dynamic error, StackTrace? stackTrace, String? functionName}) {
    _log(
      message,
      color: LoggerColor.cyan,
      error: error,
      stackTrace: stackTrace,
      functionName: functionName,
    );
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, {dynamic error, StackTrace? stackTrace, String? functionName}) {
    _log(
      message,
      color: LoggerColor.yellow,
      error: error,
      stackTrace: stackTrace,
      functionName: functionName,
    );
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, {dynamic error, StackTrace? stackTrace, String? functionName}) {
    _log(
      message,
      color: LoggerColor.red,
      error: error,
      stackTrace: stackTrace,
      functionName: functionName,
    );
  }

  /// Log a message at level [Level.Custom].
  void custom(
    dynamic message, {
    String color = LoggerColor.reset,
    dynamic error,
    StackTrace? stackTrace,
    String? functionName,
  }) {
    _log(
      message,
      color: color,
      error: error,
      stackTrace: stackTrace,
      functionName: functionName,
    );
  }

  /// Internal method to handle logging.
  void _log(
    dynamic message, {
    required String color,
    dynamic error,
    StackTrace? stackTrace,
    String? functionName,
  }) {
    final formattedMessage = '$color${message.toString()}${LoggerColor.reset}';
    final logName =
        '${LoggerColor.white}${type.toString()}${functionName == null ? "" : '.$functionName'}${LoggerColor.reset}';

    log(
      formattedMessage,
      error: error,
      stackTrace: stackTrace,
      name: logName,
    );
  }
}
