import 'package:dio/dio.dart';
import 'package:origa/http/httpurls.dart';

Future<Map<String, dynamic>> getCaseDetailsData(String id) async {
  var dio = Dio();
  try {
    Response response = await dio.get(HttpUrl.caseDetailsUrl + id,
        // queryParameters: {
        //   "q": Uri.parse(cityName),
        //   "appid": "bdb33eb6babc9d7ceb7758159297c8ad",
        //   "units": "metric",
        // },
        options: Options(
            // headers: {"host": "api.openweathermap.org"},
            validateStatus: (status) {
      return status == 200;
    }));

    return {'success': true, 'data': response.data};
  } catch (e) {
    print(e);
    // if (DioErrorType.receiveTimeout == e.type ||
    //     DioErrorType.connectTimeout == e.type) {
    //   // throw CommunicationTimeoutException(
    //   //     "Server is not reachable. Please verify your internet connection and try again");
    // } else if (DioErrorType.response == e.type) {
    //   // 4xx 5xx response
    //   // throw exception...
    // } else if (DioErrorType.other == e.type) {
    //   if (e.message.contains('SocketException')) {
    //     print("SocketException");
    //     //  throw CommunicationTimeoutException('blabla');
    //   }
    // } else {
    //   // throw CommunicationException("Problem connecting to the server. Please try again.");
    // }
    return {'success': false, 'data': e};
  }
}
