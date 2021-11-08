import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';

import 'httpurls.dart';

class DioHelper {
  Dio dio = Dio();

  DioHelper() {
    dio.options.baseUrl = HttpUrl.baseurl;
    dio.options.followRedirects = true;
    // dio.options.receiveDataWhenStatusError = true;

    dio.options.headers[HttpHeaders.acceptHeader] = 'application/json';
    dio.options.validateStatus = (int? status) {
      return status! < 400;
    };

    dio.transformer = JsonTransformer();
    //setup auth interceptor
    _setupAuthInterceptor();

    //setup log interceptor
    _setupLogInterceptor();
  }

  // ignore: always_declare_return_types
  _setupAuthInterceptor() async {
    dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      // here we can add request api intercepters
      options.headers['TENANT'] = Constants.tenant;
      return handler.next(options);
    }, onResponse:
        (Response<dynamic> response, ResponseInterceptorHandler handler) async {
      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      return handler.next(error);
    }));
  }

  static FutureOr<bool> checkDioRetry(DioError error) {
    // AppUtils.showErrorToast(error.message);
    return error.type == DioErrorType.other;
  }

  // ignore: always_declare_return_types, unused_element
  _showToast(String text) {
    // WidgetsBinding.instance.addObserver(LifecycleEventHandler(
    //     pausedCallBack: onPauseCallBack, resumeCallBack: onResumeCallBack));
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  // ignore: always_declare_return_types
  _setupLogInterceptor() {
    if (DebugMode.isInDebugMode) {
      // ignore: avoid_redundant_argument_values
      dio.interceptors.add(LogInterceptor(responseBody: false));
    }
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

Dio dio() {
  final Dio dio = DioHelper().dio;
  return dio;
}
