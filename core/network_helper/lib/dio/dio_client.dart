import 'package:cross_platform_crypto/cross_platform_crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:network_helper/utils/utils.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;
final dio = Dio();

const httpCode200 = 200;
const httpCode400 = 400;
const httpCode401 = 401;
const httpCode402 = 402;
const httpCode403 = 403;
const httpCode404 = 404;

const keyStatus = 'status';
const keyResult = 'result';
const keyData = 'data';
const keyEncryptedData = 'encryptedData';
const keyAuthorization = 'authorization';
const keyContentType = 'Content-Type';
const jsonContentType = 'application/json';
const multiPartContentType = 'multipart/form-data';
const authTypeBearer = 'Bearer';
const String baseUrl = 'https://dev-collect.m2pfintech.com/';
const String mobileBackendUrl = '$baseUrl$apiType$version$fieldAgent';
const String version = 'v1/';
const String apiType = 'mobile-backend/';
const String fieldAgent = 'agent/';

String? getMobileBackendUrl(
    {String? typeOfApi = apiType,
    String? apiVersion = version,
    String? agentType = fieldAgent}) {
  String type = typeOfApi ?? "";
  String? versionType = apiVersion ?? "";
  return baseUrl + type + versionType + fieldAgent;
}

class DioClient {
  String accessToken = '';

  final List<Interceptor>? interceptors;
  bool isMultiFormRequest = false;
  final _cryptoPlugin = CrossPlatformCrypto();

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
      return _cryptoPlugin.extractResponse(decryptResponse, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool decryptResponse = false,
      bool encryptRequestBody = false}) async {
    try {
      var response = await dio.post(
        uri,
        data: await _cryptoPlugin.checkForRequestBody(encryptRequestBody, data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _cryptoPlugin.extractResponse(decryptResponse, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(String uri,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool decryptResponse = false,
        bool encryptRequestBody = false}) async {
    try {
      var response = await dio.post(
        uri,
        data: await _cryptoPlugin.checkForRequestBody(encryptRequestBody, data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _cryptoPlugin.extractResponse(decryptResponse, response);
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
          keyAuthorization: '$authTypeBearer $accessToken',
          keyContentType: jsonContentType
        };
      } else {
        return {
          keyAuthorization: '$authTypeBearer $accessToken',
          keyContentType: jsonContentType
        };
      }
    } else {
      if (isMultiFormRequest) {
        return {keyContentType: multiPartContentType};
      } else {
        return {keyContentType: jsonContentType};
      }
    }
  }
}
