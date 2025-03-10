import 'package:core/core.dart';

import '../../models/media/space_media_model.dart';
import '../interfaces/media_datasource.dart';

class MediaDataSource extends IMediaDataSource {
  final Http _http;

  MediaDataSource({
    required Http http,
  }) : _http = http;

  @override
  Future<SpaceMediaModel> getSpaceMedia({String? date}) async {
    try {
      final request = HttpRequest(
        url: '',
        apiConnection: ApiConnection.apiConnection,
      );

      HttpResponse response = await _http.get(request);

      SpaceMediaModel spaceMediaModel = SpaceMediaModel.fromJson(response.data);

      return spaceMediaModel;
    } on HttpException catch (e) {
      Log.error(e.toString());
      throw HttpException(e.message);
    } on Exception catch (e) {
      Log.error(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<SpaceMediaModel>> getListSpaceMedia(
      {String? startDate, String? endDate, String? thumbs, int? count}) async {
    var dados = '&thumbs=true';

    if (startDate != null) {
      dados += '&start_date=$startDate';
    }
    if (endDate != null) {
      dados += '&end_date=$endDate';
    }
    if (count != null) {
      dados += '&count=$count';
    }

    try {
      final request = HttpRequest(
        url: dados,
        apiConnection: ApiConnection.apiConnection,
      );

      HttpResponse response = await _http.get(request);

      List<SpaceMediaModel> listSpaceMediaModel = (response.data as List)
          .map((e) => SpaceMediaModel.fromJson(e))
          .toList();

      return listSpaceMediaModel;
    } on HttpException catch (e) {
      Log.error(e.toString());
      throw HttpException(_http.toString());
    } on Exception catch (e) {
      Log.error(e.toString());
      throw Exception(e);
    }
  }
}
