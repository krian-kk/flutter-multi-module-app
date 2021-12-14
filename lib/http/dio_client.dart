import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/http/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static Future<String> getTokenFromSharedValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //when user login or register or refresh the token = user will get token
    // developer should try to get the token from
    //stored palces, like: shared storage or local storage db or from firebase
    //and should retrun with or without token
    String? token = _prefs.getString('accessToken');

    print('----------Autherization token----------');
    print(token);
    print('----------Done Autherization token----------');
    if(JwtDecoder.isExpired(token!)){
      // token refresh / try to get the new token

    } else {
      // old token will be used
      token = token;
    }
    return token;
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
