library flutter_utils;

import 'dart:developer';

export 'extensions/extensions.dart';
export 'local/locals.dart';
export 'models/models.dart';
export 'services/services.dart';
export 'state_management/state_management.dart';
export 'utils/utils.dart';
export 'widgets/widgets.dart';
export 'router/router.dart';

/// Main class for initializing the Flutter Utils package.
///
/// This class provides a centralized way to initialize all utilities
/// and services provided by the flutter_utils package.
class FlutterUtils {
  FlutterUtils();

  /// Initializes the Flutter Utils package.
  ///
  /// Call this method in your main() function before running your app
  /// to ensure all utilities are properly initialized.
  void initialize() {
    log('[Flutter Utils]: INITIALIZED', level: 2000, name: 'FlutterUtils');
  }
}
