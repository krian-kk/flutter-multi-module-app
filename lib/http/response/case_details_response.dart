import 'package:dio/dio.dart';
import 'package:origa/http/http_url.dart';

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

    return {"success": true, "data": response.data};
  } on DioError catch (e) {
    return {"success": false, "data": e.message};
  }
}
