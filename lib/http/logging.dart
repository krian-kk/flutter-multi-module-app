import 'package:dio/dio.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request [${options.method}] -> Path name: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'Response [${response.statusCode}] -> Path name: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'Error [${err.response?.statusCode}] -> Path name: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
