import 'dart:async';

import 'package:core/core.dart';

import 'src/app.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Environment.initialize();

      /// Inicializa os bindings
      AppBindings bindings = AppBindings();
      bindings.dependencies();

      runApp(App());
    },
    (error, stackTrace) {
      // Ferramentas de observabilidade como Sentry e Crashlytics
    },
  );
}
