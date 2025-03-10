// ignore_for_file: constant_identifier_names

import 'http_response.dart';

enum ErrorType {
  CONNECT_TIMEOUT,
  SEND_TIMEOUT,
  RECEIVE_TIMEOUT,
  RESPONSE,
  CANCEL,
  DEFAULT,
}

class HttpException implements Exception {
  // RequestOptions request;
  HttpResponse? response;
  ErrorType type;
  String? error;

  String get message => (error ?? '{}').toString();

  HttpException(
    String s, {
    // this.request,
    this.response,
    this.type = ErrorType.DEFAULT,
    this.error,
  });

  @override
  String toString() {
    return 'HttpException{response: $response, type: $type, error: $error}';
  }
}
