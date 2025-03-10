import 'package:core/core.dart';
import 'package:home/home.dart';
import 'package:media/media.dart';

class AppBindings implements Bindings {
  /// Bindings module instances
  final HomeBindings _homeBindings = HomeBindings();
  final MediaBindings _mediaBindings = MediaBindings();

  /// Bingings register
  @override
  void dependencies() {
    /// Registering the Http client
    Get.put<Http>(
      DioImpl(),
      permanent: true,
    );

    /// Module bindings
    _homeBindings.dependencies();
    _mediaBindings.dependencies();
  }
}
