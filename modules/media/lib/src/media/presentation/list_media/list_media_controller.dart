import 'package:core/core.dart';
import 'package:media/src/media/domain/repositories/media_repository.dart';
import '../../domain/entities/space_media_entity.dart';

class ListMediaController extends GetxController {
  final IMediaRepository _mediaRepository;

  var mediaList = RxList<SpaceMediaEntity>();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isFavorite = false.obs;

  String get startDateFormatted =>
      DateFormat('yyyy-MM-dd').format(startDate.value!);

  String get endDateFormatted =>
      DateFormat('yyyy-MM-dd').format(endDate.value!);

  ListMediaController({
    required IMediaRepository mediaRepository,
  }) : _mediaRepository = mediaRepository;

  @override
  Future<void> onInit() async {
    super.onInit();
    mediaList.value =
        await _mediaRepository.getListSpaceMedia(count: 5, thumbs: 'true');
  }

  void getMediaList() async {
    mediaList.value = await _mediaRepository.getListSpaceMedia(
        startDate: startDateFormatted,
        endDate: endDateFormatted,
        thumbs: 'true');
  }

  Future<void> isFavoriteMedia(SpaceMediaEntity spaceMedia) async {
    isFavorite.value = await _mediaRepository.isFavorite(spaceMedia);
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
      isFavorite.value = false;
    }
  }
}
