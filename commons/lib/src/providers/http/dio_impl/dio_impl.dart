import 'dart:convert';
import 'dart:developer';

import 'package:commons/commons.dart';

import 'interceptor/base_interceptor.dart';
import 'interceptor/log_interceptor.dart';

class DioImpl implements Http {
  final Dio _dio = Dio();

  DioImpl() {
    _dio.interceptors.add(MyLogInterceptor());
  }

  @override
  Future<HttpResponse<T>> delete<T>(HttpRequest request) async {
    try {
      Log.info("Calling method delete...");
      await _setupAuthenticatedInterceptor(
        request: request,
      );
      await _setupRequest(request);
      final Response<T> response = await _dio.delete(
        request.url,
        data: request.data,
        queryParameters: request.queryParameters,
      );
      return _mapperResponse<T>(response);
    } on DioException catch (e) {
      throw HttpException(
        e.response.toString(),
        response: _mapperResponse(e.response),
      );
    }
  }

  @override
  Future<HttpResponse<T>> get<T>(HttpRequest request) async {
    try {
      Log.info("Calling method get...");
      await _setupAuthenticatedInterceptor(
        request: request,
      );
      await _setupRequest(request);
      if (request.data != null) {
        throw HttpException("Get don't allow body params");
      }
      final Response<T> response = await _dio.get(
        request.url,
        queryParameters: request.queryParameters,
      );
      return _mapperResponse<T>(response);
    } on DioException catch (e) {
      throw HttpException(
        e.response.toString(),
        response: _mapperResponse(e.response),
      );
    }
  }

  @override
  Future<HttpResponse<T>> post<T>(HttpRequest request) async {
    try {
      Log.info("Calling method post...");
      await _setupAuthenticatedInterceptor(
        request: request,
      );
      await _setupRequest(request);
      final Response<T> response = await _dio.post(
        request.url,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return _mapperResponse<T>(response);
    } on DioException catch (e) {
      Log.error("DioException: ${e.message}");
      Log.error("Request URL: ${request.url}");
      Log.error("Request Data: ${request.data}");
      Log.error("Request Headers: ${request.headers}");
      Log.error("Response: ${e.response?.toString()}");

      throw HttpException(
        e.response.toString(),
        response: _mapperResponse(e.response),
      );
    } catch (e) {
      Log.error("Unexpected error: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<HttpResponse<T>> put<T>(HttpRequest request) async {
    try {
      Log.info("Calling method put...");
      await _setupAuthenticatedInterceptor(
        request: request,
      );
      await _setupRequest(request);
      final Response<T> response = await _dio.put(
        request.url,
        data: request.data,
        queryParameters: request.queryParameters,
      );
      return _mapperResponse<T>(response);
    } on DioException catch (e) {
      throw HttpException(
        e.response.toString(),
        response: _mapperResponse(e.response),
      );
    }
  }

  @override
  Future<HttpResponse<T>> patch<T>(HttpRequest request) async {
    try {
      Log.info("Calling method path...");
      await _setupAuthenticatedInterceptor(
        request: request,
      );
      await _setupRequest(request);
      final Response<T> response = await _dio.patch(
        request.url,
        data: request.data,
        queryParameters: request.queryParameters,
      );
      return _mapperResponse<T>(response);
    } on DioException catch (e) {
      throw HttpException(
        e.response.toString(),
        response: _mapperResponse(e.response),
      );
    }
  }

  @override
  Future<HttpResponse> download({
    required ApiConnection apiConnection,
    required String urlPath,
    required savePath,
    useInterceptors = true,
  }) async {
    try {
      Log.info("Calling method download...");
      _setupAuthenticatedInterceptor();
      if (!useInterceptors) {
        _dio.interceptors.clear();
        _dio.interceptors.add(MyLogInterceptor());
      }
      _dio.options.baseUrl = _getBaseUrl(apiConnection);
      final Response response = await _dio.download(
        urlPath,
        savePath,
      );
      return _mapperResponse(response);
    } on DioException catch (e) {
      throw HttpException(
        e.response.toString(),
        response: _mapperResponse(e.response),
      );
    }
  }

  @override
  String decodeError(dynamic e) {
    try {
      if (e.response != null) {
        var jsonContent = jsonDecode(e.error.toString());
        List errors = jsonContent["errors"];
        inspect(errors);
        return errors.first["title"] ??
            'Erro genérico'; // Constants.errorApiGeneric;
      }

      return 'Erro genérico'; //;
    } catch (e) {
      inspect(e);
      return 'Erro genérico'; //;
    }
  }

  Future<void> _setupRequest(
    HttpRequest request,
  ) async {
    _dio.options.baseUrl = _getBaseUrl(request.apiConnection);
    _dio.options.headers.addAll(request.headers ?? {});
    _dio.options.connectTimeout = const Duration(seconds: 3);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<void> _setupAuthenticatedInterceptor({
    HttpRequest? request,
  }) async {
    _dio.options.headers.clear();

    if (!request!.useInterceptors) {
      _dio.interceptors.add(MyLogInterceptor());
    } else if (EnvironmentEntity.authToken != null) {
      _dio.interceptors.add(MyLogInterceptor());
      _dio.interceptors.add(
        BaseInterceptor(),
      );
    }
  }

  HttpResponse<T> _mapperResponse<T>(Response? response) {
    if (response == null) {
      DialogInfo.showGenericErrorDialog();
      throw HttpException(
        "Response is null",
        response: HttpResponse(statusCode: 500),
      );
    }

    return HttpResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers,
    );
  }

  String _getBaseUrl(ApiConnection apiConnection) {
    switch (apiConnection) {
      case ApiConnection.apiConnection:
        if (ApiConnection.apiConnection.url == null) {
          throw HttpException(
            "apiConnection is null",
            response: HttpResponse(
              statusCode: 500,
              statusMessage: "Api Connection not found, apiConnection is null",
            ),
          );
        }
        return ApiConnection.apiConnection.url ?? "";
      case ApiConnection.otherApi:
        if (ApiConnection.otherApi.url == null) {
          throw HttpException(
            "otherApi is null",
            response: HttpResponse(
              statusCode: 500,
              statusMessage: "Api Connection not found, otherApi is null",
            ),
          );
        }
        return ApiConnection.otherApi.url ?? "";
      case ApiConnection.noApi:
        return ApiConnection.noApi.url ?? "";
    }
  }
}

class EnvironmentEntity {
  // ignore: prefer_typing_uninitialized_variables
  static var authToken;
}
