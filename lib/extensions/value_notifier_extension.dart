import 'dart:async';

import 'package:flutter/foundation.dart';

extension ValueNotifierExtension<T> on ValueNotifier<T> {
  /// Updates the value using a callback.
  /// Example: `valueNotifier.update((value) => value + 1)`
  void update(T Function(T value) updater) {
    value = updater(value);
  }

  /// Adds a listener that is called only once and then automatically removed.
  void addOneTimeListener(VoidCallback listener) {
    VoidCallback? innerListener;
    innerListener = () {
      listener();
      removeListener(innerListener!);
    };
    addListener(innerListener);
  }

  /// Debounces value updates to avoid rapid changes.
  /// Example: `valueNotifier.debounce(Duration(seconds: 1))`
  ValueNotifier<T> debounce(Duration duration) {
    final debouncedNotifier = ValueNotifier<T>(value);
    Timer? timer;

    addListener(() {
      timer?.cancel();
      timer = Timer(duration, () {
        debouncedNotifier.value = value;
      });
    });

    return debouncedNotifier;
  }

  /// Throttles value updates to limit the rate of changes.
  /// Example: `valueNotifier.throttle(Duration(seconds: 1))`
  ValueNotifier<T> throttle(Duration duration) {
    final throttledNotifier = ValueNotifier<T>(value);
    Timer? timer;

    addListener(() {
      if (timer == null || !timer!.isActive) {
        throttledNotifier.value = value;
        timer = Timer(duration, () {});
      }
    });

    return throttledNotifier;
  }

  /// Maps the value of the notifier to a new type.
  /// Example: `valueNotifier.map((value) => value.toString())`
  ValueNotifier<R> map<R>(R Function(T value) mapper) {
    final mappedNotifier = ValueNotifier<R>(mapper(value));
    addListener(() => mappedNotifier.value = mapper(value));
    return mappedNotifier;
  }

  /// Filters value updates based on a condition.
  /// Example: `valueNotifier.filter((value) => value > 10)`
  ValueNotifier<T> filter(bool Function(T value) predicate) {
    final filteredNotifier = ValueNotifier<T>(value);
    addListener(() {
      if (predicate(value)) {
        filteredNotifier.value = value;
      }
    });
    return filteredNotifier;
  }

  /// Combines two ValueNotifier instances into one.
  /// Example: `valueNotifier.combine(otherNotifier, (a, b) => a + b)`
  ValueNotifier<R> combine<U, R>(
    ValueNotifier<U> other,
    R Function(T a, U b) combiner,
  ) {
    final combinedNotifier = ValueNotifier<R>(combiner(value, other.value));
    void update() => combinedNotifier.value = combiner(value, other.value);
    addListener(update);
    other.addListener(update);
    return combinedNotifier;
  }

  /// Disposes the notifier and removes all listeners.
  void disposeWith(List<VoidCallback> disposers) {
    disposers.add(dispose);
  }
}
