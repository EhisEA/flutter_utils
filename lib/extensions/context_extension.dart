import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Extension on [BuildContext] that provides convenient access to device information,
/// screen dimensions, platform detection, and responsive design utilities.
extension ContextExtension on BuildContext {
  /// Returns the system UI padding (e.g., status bar, notch, safe areas).
  ///
  /// This includes padding for system UI obstructions like notches or status bars.
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Returns the total device screen width in logical pixels.
  double get width => MediaQuery.of(this).size.width;

  /// Returns the total device screen height in logical pixels.
  double get height => MediaQuery.of(this).size.height;

  /// Returns the available width minus horizontal system UI padding.
  ///
  /// Useful for calculating content area width that accounts for safe areas.
  double get widthWithoutPadding => width - padding.horizontal;

  /// Returns the available height minus vertical system UI padding.
  ///
  /// Useful for calculating content area height that accounts for safe areas.
  double get heightWithoutPadding => height - padding.vertical;

  /// Returns the bottom padding of the keyboard.
  double get keyboardBottomPadding => MediaQuery.of(this).viewInsets.bottom;

  /// Returns the height of the keyboard.
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Checks if the device width is greater than the specified size.
  bool isWidthGreaterThan(double size) => width > size;

  /// Checks if the device height is greater than the specified size.
  bool isHeightGreaterThan(double size) => height > size;

  /// Returns the device width, optionally subtracting a value.
  double widthWithSubtraction({double? subtract}) {
    return subtract != null ? width - subtract : width;
  }

  /// Returns the device height, optionally subtracting a value.
  double heightWithSubtraction({double? subtract}) {
    return subtract != null ? height - subtract : height;
  }

  /// Returns the device height as a percentage of the total height.
  double heightPercentage(double percentage) {
    return height * (percentage / 100);
  }

  /// Returns the device width as a percentage of the total width.
  double widthPercentage(double percentage) {
    return width * (percentage / 100);
  }

  /// Checks if the device is a mobile device (width < 600).
  bool get isMobile => width < 600;

  /// Checks if the device is a tablet (600 <= width < 1024).
  bool get isTablet => width >= 600 && width < 1024;

  /// Checks if the device is a desktop (width >= 1024).
  bool get isDesktop => width >= 1024;

  /// Checks if the device is a mobile or tablet.
  bool get isMobileOrTablet => isMobile || isTablet;

  /// Returns the width of the right side for web layouts.
  double get webRightSideWidth => 350;

  /// Checks if the app is running on a mobile device (Android or iOS).
  bool get isMobileDevice =>
      kIsWeb ? false : Platform.isAndroid || Platform.isIOS;

  /// Returns the height for empty state images or SVGs.
  double get emptyStateHeight => height / 4;

  /// Returns the height for empty state images or SVGs in bottom sheets.
  double get emptyStateBottomSheetHeight => emptyStateHeight / 2;

  /// Returns the platform type (e.g., Android, iOS, web).
  TargetPlatform get platform => Theme.of(this).platform;

  /// Checks if the app is running on Android.
  bool get isAndroid => platform == TargetPlatform.android;

  /// Checks if the app is running on iOS.
  bool get isIOS => platform == TargetPlatform.iOS;

  /// Checks if the app is running on the web.
  bool get isWeb => kIsWeb;
}
