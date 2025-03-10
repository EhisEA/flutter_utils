import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseStateNotifierViewModel<T> extends StateNotifier<T> {
  BaseStateNotifierViewModel(super.state);

  /// Optional function to show a toast message.
  /// - `message`: The text to display in the toast.
  /// - `isError`: Whether the toast should indicate an error (default: `false`).
  void Function(String message, {bool isError})? showToast;

  /// A helper function to update the state safely.
  void updateState(T Function(T state) update) {
    state = update(state);
  }
}
