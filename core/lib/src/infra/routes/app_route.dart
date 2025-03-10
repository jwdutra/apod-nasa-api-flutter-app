import 'package:core/core.dart';
import 'package:home/home.dart';
import 'package:media/media.dart';

class AppRoute {
  AppRoute();

  /// Wrapper for Get
  static final get = Get;

  /// Routes modules
  static HomeRoutes home = HomeRoutes();
  static MediaRoutes media = MediaRoutes();

  static List<GetPage> getRoutes() {
    return [
      ...home.setup(),
      ...media.setup(),
    ];
  }
}
