import 'package:flutter/material.dart';

import 'navigation.dart';

/// Mobile implementation of [NavigationService].
class MobileNavigationService extends NavigationService {
  /// Singleton instance.
  static final MobileNavigationService instance = MobileNavigationService._();
  MobileNavigationService._();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> navigateTo(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: extra);
  }

  @override
  Future<void> push(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: extra);
  }

  @override
  Future<void> replace(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: extra);
  }

  @override
  void navigateAndClearStack(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
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
  Future<void> logout(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return replace(routeName, queryParams: queryParams, extra: extra);
  }

  @override
  void goBack<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }
}
