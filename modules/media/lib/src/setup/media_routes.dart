import 'package:core/core.dart';

import '../media/presentation/list_media/list_media_view.dart';
import '../media/presentation/list_media_favorite/list_media_favorite_view.dart';
import '../media/presentation/media/media_view.dart';

class MediaRoutes {
  final String initial = '/media/initial';
  final String list = '/media/list';
  final String favorites = '/media/favorites';

  List<GetPage> setup() {
    return [
      GetPage(name: initial, page: () => MediaView()),
      GetPage(name: list, page: () => ListMediaView()),
      GetPage(name: favorites, page: () => ListMediaFavoriteView()),
    ];
  }
}
