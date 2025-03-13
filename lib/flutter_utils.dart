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

class MHIFlutterLibrary {
  MHIFlutterLibrary();

  void initialise() {
    log('[MHI Flutter Library]: INITIALISED', level: 2000, name: 'Test');
  }
}
