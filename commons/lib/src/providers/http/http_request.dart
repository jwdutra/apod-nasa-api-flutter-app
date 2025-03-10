import 'api_connection.dart';

class HttpRequest {
  final String url;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final ApiConnection apiConnection;
  final bool useInterceptors;

  HttpRequest({
    required this.url,
    required this.apiConnection,
    this.data,
    this.queryParameters,
    this.headers,
    this.useInterceptors = true,
  });
}
