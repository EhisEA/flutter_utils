import 'package:flutter/material.dart';
import 'package:flutter_utils/extensions/extensions.dart';

/// A widget that helps build responsive layouts by providing different builders
/// for mobile, tablet, and desktop views
class ResponsiveBuilder extends StatelessWidget {
  /// Required builder for mobile layout
  final Widget Function(BuildContext) mobileBuilder;

  /// Optional builder for tablet layout
  /// Falls back to mobile layout if not provided
  final Widget Function(BuildContext)? tabletBuilder;

  /// Optional builder for desktop layout
  /// Falls back to tablet layout if not provided
  final Widget Function(BuildContext)? desktopBuilder;

  const ResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    this.tabletBuilder,
    this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // Desktop view
    if (context.isDesktop) {
      // Desktop view
      if (context.isDesktop) {
        return desktopBuilder?.call(context) ??
            tabletBuilder?.call(context) ??
            mobileBuilder(context);
      }
    }

    // Tablet view
    if (context.isTablet) {
      return tabletBuilder != null ? tabletBuilder!(context) : mobileBuilder(context);
    }

    // Mobile view (default)
    return mobileBuilder(context);
  }
}
