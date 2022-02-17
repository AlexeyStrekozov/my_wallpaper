import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:my_wallpaper/common/constants.dart';
import 'package:my_wallpaper/common/providers/network_provider.dart';

abstract class Encodable {
  Map<String, dynamic> toJson();
}

enum NetworkMethod { get, post, put, patch, delete, download }

class DioServiceException implements Exception {
  final String message;

  DioServiceException(this.message);

  @override
  String toString() => message;
}

class DioWrapper {
  late final Dio _dio;
  late final ResponseType _responseType;

  Future<void> init({
    required NetworkProvider networkProvider,
    ResponseType responseType = ResponseType.json,
  }) async {
    _responseType = responseType;

    final logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );

    final headerInterceptor = HeaderInterceptor();

    final errorInterceptor = ErrorInterceptor();

    _dio = Dio(BaseOptions(
      connectTimeout: 40000,
      receiveTimeout: 40000,
      sendTimeout: 40000,
      responseType: _responseType,
    ));

    _dio.interceptors.clear();

    _dio.interceptors.addAll([
      logInterceptor,
      headerInterceptor,
      errorInterceptor,
    ]);

    _dio.interceptors.requestLock.unlock();
  }

  void changeResponseType({required ResponseType responseType}) {
    _responseType = responseType;

    _dio.interceptors.requestLock.lock();

    _dio.options.responseType = _responseType;

    _dio.interceptors.requestLock.unlock();
  }

  ///
  ///[request] can be [Encodable], [List<Encodable,>], [Map<String, dynamic>], [FormData]
  ///
  Future<Response<dynamic>> sendRequest({
    required String baseUrl,
    required String url,
    required NetworkMethod method,
    dynamic request,
    Options? options,
    Map<String, dynamic>? queryParameters,
    String? savePath,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    if (method == NetworkMethod.get) {
      if (request == null) {
        final response = await _getMethod(
          baseUrl: baseUrl,
          url: url,
          queryParameters: queryParameters,
          options: options,
        );
        return response;
      } else {
        throw DioServiceException('Can not send "request" with GET method');
      }
    } else if (method == NetworkMethod.post) {
      final response = await _postMethod(
        baseUrl: baseUrl,
        url: url,
        queryParameters: queryParameters,
        request: request,
        options: options,
      );

      return response;
    } else if (method == NetworkMethod.put) {
      final response = await _putMethod(
        baseUrl: baseUrl,
        url: url,
        queryParameters: queryParameters,
        request: request,
        options: options,
      );

      return response;
    } else if (method == NetworkMethod.patch) {
      final response = await _patchMethod(
        baseUrl: baseUrl,
        url: url,
        queryParameters: queryParameters,
        request: request,
        options: options,
      );

      return response;
    } else if (method == NetworkMethod.delete) {
      final response = await _deleteMethod(
        baseUrl: baseUrl,
        url: url,
        queryParameters: queryParameters,
        request: request,
        options: options,
      );

      return response;
    } else if (method == NetworkMethod.download) {
      final response = await _getDownload(
        baseUrl: baseUrl,
        queryParameters: queryParameters,
        options: options,
        savePath: savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken ?? CancelToken(),
      );

      return response;
    } else {
      throw DioServiceException('Unknown network method');
    }
  }

  dynamic _getDataFromRequest({required dynamic request}) {
    if (request is Encodable) {
      return request.toJson();
    } else if (request is List<Encodable>) {
      return json.encode(
          List<Map<String, dynamic>>.from(request.map((x) => x.toJson())));
    } else if (request is Map<String, dynamic>) {
      return request;
    } else if (request is FormData) {
      return request;
    } else {
      throw DioServiceException('Unknown request type');
    }
  }

  Future<Response<dynamic>> _postMethod({
    required String baseUrl,
    required String url,
    required dynamic request,
    required Options? options,
    required Map<String, dynamic>? queryParameters,
  }) async {
    final data = request == null ? null : _getDataFromRequest(request: request);

    final response = await _dio.post(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  Future<Response<dynamic>> _getMethod({
    required String baseUrl,
    required String url,
    required Options? options,
    required Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      '$baseUrl$url',
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  Future<Response<dynamic>> _putMethod({
    required String baseUrl,
    required String url,
    required dynamic request,
    required Options? options,
    required Map<String, dynamic>? queryParameters,
  }) async {
    final data = request == null ? null : _getDataFromRequest(request: request);

    final response = await _dio.put(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  Future<Response<dynamic>> _patchMethod({
    required String baseUrl,
    required String url,
    required dynamic request,
    required Options? options,
    required Map<String, dynamic>? queryParameters,
  }) async {
    final data = request == null ? null : _getDataFromRequest(request: request);

    final response = await _dio.patch(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  Future<Response<dynamic>> _deleteMethod({
    required String baseUrl,
    required String url,
    required dynamic request,
    required Options? options,
    required Map<String, dynamic>? queryParameters,
  }) async {
    final data = request == null ? null : _getDataFromRequest(request: request);

    final response = await _dio.delete(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  Future<Response<dynamic>> _getDownload({
    required String baseUrl,
    required Options? options,
    required Map<String, dynamic>? queryParameters,
    required String? savePath,
    required void Function(int, int)? onReceiveProgress,
    required CancelToken cancelToken,
  }) async {
    final response = await _dio.download(
      baseUrl,
      savePath,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    return response;
  }
}

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[Constants.authTokenKey] = Constants.constAuthTokenValue;

    return super.onRequest(options, handler);
  }
}

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
