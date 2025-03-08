extension IterableExtension<T> on Iterable<T> {
  /// Returns the first element, or null if the iterable is empty.
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element, or null if the iterable is empty.
  T? get lastOrNull => isEmpty ? null : last;

  /// Returns the element at the specified index, or null if the index is out of bounds.
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return elementAt(index);
  }

  /// Returns the first element that satisfies the condition, or null if no such element exists.
  T? firstWhereOrNull(bool Function(T) predicate) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// Returns the last element that satisfies the condition, or null if no such element exists.
  T? lastWhereOrNull(bool Function(T) predicate) {
    T? result;
    for (final element in this) {
      if (predicate(element)) result = element;
    }
    return result;
  }

  /// Maps the iterable and removes null values.
  Iterable<R> mapNotNull<R>(R? Function(T) transform) sync* {
    for (final element in this) {
      final result = transform(element);
      if (result != null) yield result;
    }
  }

  /// Returns an iterable with distinct elements.
  Iterable<T> distinct() sync* {
    final uniqueSet = <T>{};
    for (final element in this) {
      if (uniqueSet.add(element)) yield element;
    }
  }

  /// Returns the sum of the iterable elements (for num types).
  num get sum {
    if (T == num) {
      return (this as Iterable<num>).fold(0, (a, b) => a + b);
    }
    throw UnsupportedError('Sum is only supported for Iterable<num>');
  }

  /// Returns the average of the iterable elements (for num types).
  double get average {
    if (T == num) {
      return (this as Iterable<num>).sum / length;
    }
    throw UnsupportedError('Average is only supported for Iterable<num>');
  }

  /// Returns the minimum value in the iterable (for num types).
  num get min {
    if (T == num) {
      return (this as Iterable<num>).reduce((a, b) => a < b ? a : b);
    }
    throw UnsupportedError('Min is only supported for Iterable<num>');
  }

  /// Returns the maximum value in the iterable (for num types).
  num get max {
    if (T == num) {
      return (this as Iterable<num>).reduce((a, b) => a > b ? a : b);
    }
    throw UnsupportedError('Max is only supported for Iterable<num>');
  }

  /// Checks if the iterable is null or empty.
  bool get isNullOrEmpty => isEmpty;

  /// Returns the iterable if it is not empty; otherwise, returns the result of [orElse].
  Iterable<T> ifEmpty(Iterable<T> Function() orElse) {
    return isEmpty ? orElse() : this;
  }

  /// Partitions the iterable into two lists based on a condition.
  (List<T>, List<T>) partition(bool Function(T) predicate) {
    final first = <T>[];
    final second = <T>[];
    for (final element in this) {
      if (predicate(element)) {
        first.add(element);
      } else {
        second.add(element);
      }
    }
    return (first, second);
  }
}
