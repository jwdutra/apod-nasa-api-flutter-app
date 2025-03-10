import 'package:media/src/media/domain/entities/space_media_entity.dart';

abstract class IMediaRepository {
  Future<SpaceMediaEntity> getSpaceMedia({String? date});
  Future<List<SpaceMediaEntity>> getListSpaceMedia(
      {String? startDate, String? endDate, String? thumbs, int? count});
  Future<List<SpaceMediaEntity>> setFavoriteSpaceMedia(
      SpaceMediaEntity spaceMedia);
  Future<List<SpaceMediaEntity>> getListFavorites();
  Future<List<SpaceMediaEntity>> removeFavoriteSpaceMedia(
      SpaceMediaEntity spaceMedia);
  Future<bool> isFavorite(SpaceMediaEntity spaceMedia);
}
