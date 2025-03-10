import 'package:commons/commons.dart';

class HttpResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  final Headers? headers;

  HttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.headers,
  });

  bool isSuccess() {
    return statusCode == 200 || statusCode == 201;
  }
}
