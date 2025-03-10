import 'package:commons/src/providers/http/api_connection.dart';
import 'package:commons/src/providers/http/http_request.dart';
import 'package:commons/src/providers/http/http_response.dart';

abstract class Http {
  Future<HttpResponse<T>> get<T>(HttpRequest request);

  Future<HttpResponse<T>> post<T>(HttpRequest request);

  Future<HttpResponse<T>> put<T>(HttpRequest request);

  Future<HttpResponse<T>> delete<T>(HttpRequest request);

  Future<HttpResponse<T>> patch<T>(HttpRequest request);

  Future<HttpResponse> download({
    required ApiConnection apiConnection,
    required String urlPath,
    required savePath,
    bool useInterceptors,
  });

  String decodeError(dynamic e);
}
