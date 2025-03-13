import 'package:flutter/material.dart';

/// Abstract class defining navigation operations for both Web and Mobile.
///
/// Implementations: [WebNavigationService] & [MobileNavigationService].
abstract class NavigationService {
  /// Global navigation key used for routing.
  GlobalKey<NavigatorState>? get navigatorKey;

  /// Navigates to a new route.
  ///
  /// - `routeName`: The named route for Mobile or path for Web.
  /// - `queryParams`: Optional query parameters for Web navigation.
  /// - `extra`: Additional data passed to the next screen.
  Future<void> navigateTo(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Pushes a new route onto the stack.
  ///
  /// - `routeName`: The named route for Mobile or path for Web.
  /// - `queryParams`: Optional query parameters for Web navigation.
  /// - `extra`: Additional data passed to the next screen.
  Future<void> push(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Replaces the current route with a new one.
  ///
  /// - `routeName`: The named route for Mobile or path for Web.
  /// - `queryParams`: Optional query parameters for Web navigation.
  /// - `extra`: Additional data passed to the next screen.
  Future<void> replace(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Clears all previous routes and navigates to a new one.
  ///
  /// - `routeName`: The named route for Mobile or path for Web.
  /// - `queryParams`: Optional query parameters for Web navigation.
  /// - `extra`: Additional data passed to the next screen.
  void navigateAndClearStack(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Pops routes until a specific route is found.
  ///
  /// - `routeName`: The named route to stop at.
  void popUntil(String routeName);

  /// Logs out the user and redirects to a specified route.
  ///
  /// - `routeName`: The logout redirection route for Mobile or path for Web.
  /// - `queryParams`: Optional query parameters for Web navigation.
  /// - `extra`: Additional data passed to the next screen.
  Future<void> logout(String routeName,
      {Map<String, String>? queryParams, Map<String, dynamic>? extra});

  /// Pops the current route, going back to the previous screen.
  ///
  /// - `result`: Optional result data to return to the previous screen.
  void goBack<T extends Object?>([T? result]);
}
