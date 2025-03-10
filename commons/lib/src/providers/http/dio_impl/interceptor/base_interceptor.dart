import 'package:commons/commons.dart';

class BaseInterceptor extends Interceptor {
  BaseInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["Content-Type"] = "application/json";
    options.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin';
    return handler.next(options);
  }
}
