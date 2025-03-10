import 'package:flutter/foundation.dart';
import 'dart:async';

/// A utility class that helps control the rate of execution of callbacks.
/// Useful for scenarios like search-as-you-type or form validation
/// where you want to wait for user input to stabilize before taking action.
class Debouncer {
  /// The delay duration in milliseconds before executing the callback.
  final int milliseconds;

  /// Optional identifier for the debouncer instance.
  final String? tag;

  /// Internal timer to track delayed execution.
  Timer? _timer;

  /// Constructor requiring milliseconds delay and optional tag.
  Debouncer({
    required this.milliseconds,
    this.tag,
  });

  /// Generates a unique identifier for this debouncer instance.
  /// Returns the tag if provided, otherwise the current timestamp.
  String get id => tag ?? DateTime.now().toIso8601String();

  /// Executes a one-time delayed callback.
  /// Cancels any pending execution before starting a new timer.
  /// [action] The callback function to execute after delay.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Executes a callback periodically at the specified interval.
  /// Cancels any existing periodic timer before starting a new one.
  /// [action] The callback function to execute periodically.
  void runPeriodic(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) => action(),
    );
  }

  /// Executes an asynchronous callback after the specified delay.
  /// Cancels any pending execution before starting a new timer.
  /// [action] The async callback function to execute after delay.
  Future<void> runAsync(Future<void> Function() action) async {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () async {
      try {
        await action();
      } catch (e) {
        debugPrint('Debouncer error: $e');
      }
    });
  }

  /// Cancels any pending timer execution.
  /// Should be called when the debouncer is no longer needed.
  void cancel() {
    _timer?.cancel();
  }
}
