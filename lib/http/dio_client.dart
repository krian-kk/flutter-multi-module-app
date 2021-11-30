import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/http/logging.dart';

class DioClient {
  static dynamic dioConfig() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: HttpUrl.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        followRedirects: true,
        headers: (null != getTokenFromSharedValues() ||
                '' != getTokenFromSharedValues())
            ? {
                'authorization': 'Bearer ${getTokenFromSharedValues()}',
              }
            : null,
        contentType: 'application/json',
      ),
    )..interceptors.add(Logging());
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  //developer want get from stored while login/register
  static String getTokenFromSharedValues() {
    return '';
  }

  static dynamic errorHandling(DioError e) {
    /// When the server response, but with a incorrect status, such as 404, 503
    if (e.type == DioErrorType.response) {
      return DioErrorType.response;
    }
    if (e.type == DioErrorType.connectTimeout) {
      return 'Please check your internet connection';
    }
    if (e.type == DioErrorType.receiveTimeout) {
      return 'Unable to connect to the server';
    }
    if (e.type == DioErrorType.other) {
      return 'Something went wrong';
    }

    /// When the request is cancelled, dio will throw a error with this type.
    if (e.type == DioErrorType.cancel) {
      return 'Something went wrong';
    }
  }

  static List<dynamic>? listOfMultiPart(List<File>? file) {
    final List<dynamic> multiPartValues = [];
    for (File element in file!) {
      multiPartValues.add(MultipartFile.fromFile(
        element.path,
        filename: element.path.split('/').last,
      ));
    }
    return multiPartValues;
  }
}

//This transformer runs the json decoding in a background thread.
//Thus returing a Future of Map
class JsonTransformer extends DefaultTransformer {
  JsonTransformer() : super(jsonDecodeCallback: _parseJson);
}

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> _parseJson(String text) {
  return compute(_parseAndDecode, text);
}
