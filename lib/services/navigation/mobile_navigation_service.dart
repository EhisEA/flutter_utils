import 'package:flutter/material.dart';
import 'navigation_service.dart';

/// Mobile implementation of [NavigationService].
class MobileNavigationService extends NavigationService {
  /// Singleton instance.
  static final MobileNavigationService instance = MobileNavigationService._();
  MobileNavigationService._();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<T?> navigateTo<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: extra);
  }

  @override
  Future<T?> push<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: extra);
  }

  @override
  Future<T?> replace<T, TO>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(routeName, arguments: extra);
  }

  @override
  Future<T?> navigateAndClearStack<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (_) => false,
      arguments: extra,
    );
  }

  @override
  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil((route) => route.settings.name == routeName);
  }

  @override
  Future<T?> logout<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return replace<T, void>(routeName, queryParams: queryParams, extra: extra);
  }

  @override
  void goBack<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }
}
