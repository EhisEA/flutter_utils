import 'package:flutter/foundation.dart';
import 'package:flutter_utils/models/models.dart';
import 'package:flutter_utils/utils/utils.dart';

class BaseChangeNotifierViewModel extends ChangeNotifier {
  late final _logger = AppLogger(runtimeType);
  AppLogger get logger => _logger;

  //======================================================
  //==================== BASE STATE =======================
  //======================================================
  ViewModelState _baseState = const ViewModelState.idle();
  ViewModelState get baseState => _baseState;

  /// if state is busy
  bool get isBaseBusy => _baseState.maybeWhen<bool>(busy: () => true, orElse: () => false);

  /// if state is idle
  bool get isBaseIdle => _baseState.maybeWhen<bool>(idle: () => true, orElse: () => false);

  /// if state is error
  bool get isBaseError => _baseState.maybeWhen<bool>(error: (value) => true, orElse: () => false);

  /// get error message
  String get getBaseError =>
      _baseState.maybeWhen<String>(error: (value) => value.message, orElse: () => "");

  /// alter base state
  void changeBaseState(ViewModelState newState) {
    _baseState = newState;
    _notify();
  }

  //======================================================
  //==================== GROWABLE STATES =================
  //======================================================
  final Map<String, ViewModelState> _states = {};
  Map<String, ViewModelState> get states => Map.unmodifiable(_states);

  /// Add or update a state with a unique key
  void setState(String key, ViewModelState newState) {
    _states[key] = newState;
    _notify();
  }

  /// Get a state by key (returns `null` if key does not exist)
  ViewModelState? getState(String key) => _states[key];

  /// Check if a state exists for a given key
  bool hasState(String key) => _states.containsKey(key);

  /// Remove a specific state by key
  void removeState(String key) {
    if (_states.containsKey(key)) {
      _states.remove(key);
      _notify();
    }
  }

  /// Clear all additional states
  void clearStates() {
    _states.clear();
    _notify();
  }

  //======================================================
  //==================== DISPOSE SECTION =================
  //======================================================
  bool _disposed = false;
  bool get isDisposed => _disposed;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  /// Notify listeners only if not disposed
  void _notify() {
    if (!isDisposed) notifyListeners();
  }
}
