import 'package:core/core.dart';

import '../home/home_view.dart';

class HomeRoutes {
  final String initial = '/home/initial';

  List<GetPage> setup() {
    return [
      GetPage(name: initial, page: () => HomeView()),
    ];
  }
}
