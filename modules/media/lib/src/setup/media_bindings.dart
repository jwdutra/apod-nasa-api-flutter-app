import 'package:core/core.dart';
import 'package:media/src/media/domain/repositories/media_repository.dart';

import '../media/data/datasources/implementations/media_datasource.dart';
import '../media/data/datasources/interfaces/media_datasource.dart';
import '../media/data/repositories/media_repository.dart';
import '../media/presentation/list_media/list_media_controller.dart';
import '../media/presentation/list_media_favorite/list_media_favorite_controller.dart';
import '../media/presentation/media/media_controller.dart';

class MediaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaController>(
      () => MediaController(
        mediaRepository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<ListMediaController>(
      () => ListMediaController(
        mediaRepository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<ListMediaFavoriteController>(
      () => ListMediaFavoriteController(
        mediaRepository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<IMediaDataSource>(
      () => MediaDataSource(
        http: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<IMediaRepository>(
      () => MediaRepository(
        mediaDataSource: Get.find(),
      ),
      fenix: true,
    );
  }
}
