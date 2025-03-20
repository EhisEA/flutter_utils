import 'package:flutter/material.dart';

/// Abstract class defining navigation operations for both Web and Mobile.
///
/// Implementations: [WebNavigationService] & [MobileNavigationService].
abstract class NavigationService {
  /// Global navigation key used for routing.
  GlobalKey<NavigatorState> get navigatorKey;

  /// Navigates to a new route.
  ///
  /// - [routeName]: The named route (Mobile) or path (Web).
  /// - [queryParams]: Optional query parameters (Web only).
  /// - [extra]: Additional data passed to the next screen.
  Future<T?> navigateTo<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Pushes a new route onto the navigation stack.
  Future<T?> push<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Replaces the current route with a new one.
  Future<T?> replace<T, TO>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Clears all previous routes and navigates to a new one.
  Future<T?> navigateAndClearStack<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Pops routes until a specific route is reached.
  void popUntil(String routeName);

  /// Logs out the user and redirects to a specified route.
  Future<T?> logout<T>(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Pops the current route, returning optional data.
  void goBack<T extends Object?>([T? result]);
}
