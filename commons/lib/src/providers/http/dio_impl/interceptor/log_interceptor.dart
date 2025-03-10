import 'package:commons/commons.dart';

class MyLogInterceptor extends Interceptor {
  var logger = Logger();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Log.info(
      "Request ${options.baseUrl}${options.path}"
      " \nheaders: ${options.headers}"
      " \nqueryParams: ${options.queryParameters}"
      " \ndata: ${options.data}",
    );
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.info("Response "
        "\nPath ${response.requestOptions.path} "
        "\nStatus code ${response.statusCode} "
        "\nbody ${response.toString()}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Log.error("Response error "
        "\nPath ${err.requestOptions.path}"
        "\nStatus code ${err.response?.statusCode.toString() ?? ""} "
        "${err.response.toString()}");
    DialogInfo.showGenericErrorDialog();

    return super.onError(err, handler);
  }
}
