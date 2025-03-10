import '../../models/media/space_media_model.dart';

abstract class IMediaDataSource {
  Future<SpaceMediaModel> getSpaceMedia({String? date});
  Future<List<SpaceMediaModel>> getListSpaceMedia(
      {String? startDate, String? endDate, String? thumbs, int? count});
}
