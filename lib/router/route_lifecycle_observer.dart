import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

/// A custom [NavigatorObserver] that logs and tracks active navigation routes.
///
/// This observer helps monitor route changes (push, pop, replace, and remove)
/// and keeps a list of currently active routes.
class RouteLifecycleObserver extends NavigatorObserver {
  /// Logger instance for debugging route changes.
  final AppLogger _logger = const AppLogger(RouteLifecycleObserver);

  /// List of currently active routes.
  final List<Route> activeRoutes = [];

  /// Singleton instance of [AppRouteObserver] for easy access across the app.
  static RouteLifecycleObserver routeObserver = RouteLifecycleObserver();

  /// Called when a new route is pushed onto the navigator stack.
  ///
  /// - Logs the pushed route name.
  /// - Adds the new route to [activeRoutes].
  @override
  void didPush(Route route, Route? previousRoute) {
    _logger.v(route.settings.name, functionName: "didPush");
    activeRoutes.add(route);
    super.didPush(route, previousRoute);
  }

  /// Called when a route is replaced with a new one.
  ///
  /// - Logs the new and old route names.
  /// - Updates the [activeRoutes] list accordingly.
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _logger.v(newRoute?.settings.name, functionName: "didReplace::add");
    _logger.v(oldRoute?.settings.name, functionName: "didReplace::remove");

    if (newRoute != null) activeRoutes.add(newRoute);
    if (oldRoute != null) activeRoutes.remove(oldRoute);

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// Called when a route is popped from the navigator stack.
  ///
  /// - Logs the popped and previous route names.
  /// - Removes the popped route from [activeRoutes].
  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.v(route.settings.name, functionName: "didPop::remove");
    _logger.v(previousRoute?.settings.name, functionName: "didPop::Active");

    activeRoutes.remove(route);
    super.didPop(route, previousRoute);
  }

  /// Called when a route is removed without being popped (e.g., during a back gesture).
  ///
  /// - Logs the removed and previous route names.
  /// - Removes the route from [activeRoutes].
  @override
  void didRemove(Route route, Route? previousRoute) {
    _logger.v(route.settings.name, functionName: "didRemove::remove");
    _logger.v(previousRoute?.settings.name, functionName: "didRemove::Active");

    activeRoutes.remove(route);
    super.didRemove(route, previousRoute);
  }

  /// Checks if a specific route is currently active in the navigator stack.
  ///
  /// - Returns `true` if the route with [routeName] exists in [activeRoutes], otherwise `false`.
  bool isRouteActive(String routeName) {
    return activeRoutes.any((route) => route.settings.name == routeName);
  }
}
