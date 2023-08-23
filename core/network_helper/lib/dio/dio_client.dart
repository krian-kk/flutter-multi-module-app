import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;
final dio = Dio();

const httpCode200 = 200;
const httpCode400 = 400;
const httpCode401 = 401;
const httpCode402 = 402;
const httpCode403 = 403;
const httpCode404 = 404;

const responseStatusKey = 'status';
const responseResultKey = 'result';

const String baseUrl = 'https://uat-sbic-collect.m2pfintech.com/';
const String mobileBackendUrl = '$baseUrl$apiType$version$fieldAgent';
const String version = 'v1/';
const String apiType = 'mobile-backend/';
const String fieldAgent = 'agent/';

class DioClient {
  String accessToken = '';

  final List<Interceptor>? interceptors;
  bool isMultiFormRequest = false;

  DioClient(baseUrl,
      {this.interceptors,
      this.accessToken = '',
      this.isMultiFormRequest = false}) {
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: _defaultReceiveTimeout)
      ..httpClientAdapter
      ..options.headers = _getHeadersConfig(accessToken, isMultiFormRequest);
    if (interceptors?.isNotEmpty ?? false) {
      dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
  }

  Future<dynamic> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool decryptResponse = false}) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return extractResponse(decryptResponse, response);
    } catch (e) {
      rethrow;
    }
  }

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  Future<dynamic> extractResponse(
      bool decryptResponse, Response<dynamic> response) async {
    if (response.data[responseStatusKey] == httpCode200 && decryptResponse) {
      final Map<String, dynamic> responseData = {
        'data': response.data[responseResultKey]
      };
      String text =
          await platform.invokeMethod('getDecryptedData', responseData);
      response.data[responseResultKey] = json.decode(text);
    }
    return response.data;
  }

  Future<dynamic> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool decryptResponse = true}) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, String> _getHeadersConfig(
      String accessToken, bool isMultiFormRequest) {
    if (accessToken.isNotEmpty) {
      if (isMultiFormRequest) {
        return {
          'authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        };
      } else {
        return {
          'authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        };
      }
    } else {
      if (isMultiFormRequest) {
        return {'Content-Type': 'multipart/form-data'};
      } else {
        return {'Content-Type': 'application/json'};
      }
    }
  }
}
