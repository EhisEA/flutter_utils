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
  const AsyncState.data(T data)
      : this._(data: data, isLoading: false, hasError: false);

  /// State indicating an error occurred.
  const AsyncState.error(String error)
      : this._(isLoading: false, hasError: true, error: error);

  /// Returns `true` if valid data is available.
  bool get hasData => data != null;

  /// Pattern matching method for handling different states.
  ///
  /// Provides a type-safe way to handle all possible states of [AsyncState].
  ///
  /// Example:
  /// ```dart
  /// state.when(
  ///   initial: () => Text('No data'),
  ///   loading: () => CircularProgressIndicator(),
  ///   data: (data) => Text('Data: $data'),
  ///   error: (error) => Text('Error: $error'),
  /// )
  /// ```
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) data,
    required R Function(String error) error,
  }) {
    if (isLoading) {
      return loading();
    } else if (hasError && this.error != null) {
      return error(this.error!);
    } else if (hasData && this.data != null) {
      return data(this.data as T);
    } else {
      return initial();
    }
  }

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
