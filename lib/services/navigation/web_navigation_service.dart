import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_service.dart';

/// Web implementation of [NavigationService].
class WebNavigationService extends NavigationService {
  /// Singleton instance.
  static final WebNavigationService instance = WebNavigationService._();
  WebNavigationService._();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter goRouter;

  @override
  Future<void> navigateTo(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) async {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    return goRouter.go(uri, extra: extra);
  }

  @override
  Future<void> push(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    return goRouter.push(uri, extra: extra);
  }

  @override
  Future<void> replace(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    return goRouter.replace(uri, extra: extra);
  }

  @override
  void navigateAndClearStack(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    goRouter.go(uri, extra: extra);
  }

  @override
  void popUntil(String routeName) {
    goRouter.refresh();
    return goRouter.pop((location) => location == routeName);
  }

  @override
  Future<void> logout(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) {
    return replace(routeName, queryParams: queryParams, extra: extra);
  }

  @override
  void goBack<T extends Object?>([T? result]) {
    return goRouter.pop(result);
  }
}
