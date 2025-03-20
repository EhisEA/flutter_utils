import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_service.dart';

/// Web implementation of [NavigationService].
class WebNavigationService extends NavigationService {
  /// Singleton instance.
  static final WebNavigationService instance = WebNavigationService._();
  WebNavigationService._() {
    _initializeRouter();
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter goRouter;

  /// Initializes the GoRouter instance.
  void _initializeRouter() {
    goRouter = GoRouter(
      navigatorKey: navigatorKey,
      routes: [
        // Define your routes here if necessary
      ],
    );
  }

  @override
  Future<T?> navigateTo<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) async {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    goRouter.go(uri, extra: extra);
    return null;
  }

  @override
  Future<T?> push<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) async {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    goRouter.push(uri, extra: extra);
    return null;
  }

  @override
  Future<T?> replace<T, TO>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) async {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    goRouter.replace(uri, extra: extra);
    return null;
  }

  @override
  Future<T?> navigateAndClearStack<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) async {
    final uri = Uri(path: routeName, queryParameters: queryParams).toString();
    goRouter.replace(uri, extra: extra);
    return null;
  }

  @override
  void popUntil(String routeName) {
    while (goRouter.canPop()) {
      goRouter.pop();
    }
    goRouter.go(routeName);
  }

  @override
  Future<T?> logout<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra}) async {
    return replace<T, void>(routeName, queryParams: queryParams, extra: extra);
  }

  @override
  void goBack<T extends Object?>([T? result]) {
    if (goRouter.canPop()) {
      goRouter.pop(result);
    }
  }
}
