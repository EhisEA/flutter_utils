import 'package:flutter/foundation.dart';

@immutable
class AsyncState<T> {
  final T? data;
  final bool isLoading;
  final bool hasError;
  final String? error;

  const AsyncState._({
    this.data,
    required this.isLoading,
    required this.hasError,
    this.error,
  });

  /// Default initial state with no data, no loading, and no error.
  const AsyncState.initial() : this._(isLoading: false, hasError: false);

  /// State indicating a loading process.
  const AsyncState.loading() : this._(isLoading: true, hasError: false);

  /// State with successfully loaded data.
  const AsyncState.data(T data) : this._(data: data, isLoading: false, hasError: false);

  /// State indicating an error occurred.
  const AsyncState.error(String error) : this._(isLoading: false, hasError: true, error: error);

  /// Returns `true` if valid data is available.
  bool get hasData => data != null;

  /// Creates a new state with updated properties.
  AsyncState<T> copyWith({
    T? data,
    bool? isLoading,
    bool? hasError,
    String? error,
  }) {
    return AsyncState._(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
    );
  }
}
