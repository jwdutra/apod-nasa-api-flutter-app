import 'package:core/core.dart';

class HomeController extends GetxController {
  late String name;

  HomeController() : super() {
    name = 'HomeController';
  }

  @override
  void onInit() {
    super.onInit();
    Log.info('Init $name');
  }
}
