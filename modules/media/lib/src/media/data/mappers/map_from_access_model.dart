import '../../domain/entities/space_media_entity.dart';
import '../models/media/space_media_model.dart';

extension MapFromSpaceMediaModel on SpaceMediaModel {
  SpaceMediaEntity toSpaceMediaEntity() {
    return SpaceMediaEntity(
        copyright: copyright,
        title: title,
        explanation: explanation,
        mediaType: mediaType,
        url: url,
        hdurl: hdurl,
        serviceVersion: serviceVersion,
        date: date,
        thumbnailUrl: thumbnailUrl);
  }

  List<SpaceMediaEntity> toSpaceMediaEntityList(List<SpaceMediaModel> models) {
    return models.map((model) => model.toSpaceMediaEntity()).toList();
  }
}
