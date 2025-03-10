import 'package:core/core.dart';
import 'package:media/src/media/domain/repositories/media_repository.dart';
import '../../domain/entities/space_media_entity.dart';

class MediaController extends GetxController with GetTickerProviderStateMixin {
  final IMediaRepository _mediaRepository;

  var media = Rxn<SpaceMediaEntity>();
  var isFavorite = false.obs;
  SpaceMediaEntity? externMedia;

  MediaController({
    required IMediaRepository mediaRepository,
  }) : _mediaRepository = mediaRepository;

  @override
  Future<void> onInit() async {
    super.onInit();

    media.value = await _mediaRepository.getSpaceMedia();

    isFavorite.value = await _mediaRepository.isFavorite(media.value!);
  }

  Future<void> setFavorite(SpaceMediaEntity spaceMedia) async {
    try {
      if (isFavorite.value) {
        await _mediaRepository.removeFavoriteSpaceMedia(spaceMedia);
        isFavorite.value = false;
      } else {
        await _mediaRepository.setFavoriteSpaceMedia(spaceMedia);
        isFavorite.value = true;
      }
    } catch (e) {
      DialogInfo.showGenericErrorDialog();
      throw Exception(e);
    }
  }
}
