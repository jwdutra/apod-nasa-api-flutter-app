import 'package:core/core.dart';
import 'package:media/src/media/domain/repositories/media_repository.dart';
import '../../domain/entities/space_media_entity.dart';

class ListMediaFavoriteController extends GetxController {
  final IMediaRepository _mediaRepository;

  var mediaList = RxList<SpaceMediaEntity>();
  var isFavorite = false.obs;

  ListMediaFavoriteController({
    required IMediaRepository mediaRepository,
  }) : _mediaRepository = mediaRepository;

  @override
  Future<void> onInit() async {
    super.onInit();
    mediaList.value = await _mediaRepository.getListFavorites();
  }

  Future<bool> isFavoriteMedia(SpaceMediaEntity spaceMedia) async {
    bool isFavoriteMedia = await _mediaRepository.isFavorite(spaceMedia);
    isFavorite.value = isFavoriteMedia;
    return isFavoriteMedia;
  }

  Future<void> setFavorite(SpaceMediaEntity spaceMedia) async {
    try {
      if (isFavorite.value) {
        mediaList.value =
            await _mediaRepository.removeFavoriteSpaceMedia(spaceMedia);
        isFavorite.value = false;
      } else {
        mediaList.value =
            await _mediaRepository.setFavoriteSpaceMedia(spaceMedia);
        isFavorite.value = true;
      }
    } catch (e) {
      isFavorite.value = false;
    }
  }
}
