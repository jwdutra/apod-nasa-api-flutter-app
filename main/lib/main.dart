import 'dart:async';

import 'package:core/core.dart';

import 'src/app.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Environment.initialize();

    var hiveBoxPath = 'nasa_app';
    if (Environment.platform != 'web') {
      var appDocumentDirectory = await getApplicationDocumentsDirectory();
      hiveBoxPath = '${appDocumentDirectory.path}/nasa_app';
    }
    Hive.init(hiveBoxPath);

    /// Inicializa os bindings
    AppBindings bindings = AppBindings();
    bindings.dependencies();

    runApp(App());
  }, (error, stackTrace) {
    //SentryObserver.captureException(error, stackTrace: stackTrace);
    //FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
