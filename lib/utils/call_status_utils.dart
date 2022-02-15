import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';

class CallCustomerStatus {
  CallCustomerStatus._();
  static Future<bool> callStatusCheck({required String callId}) async {
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.POST,
      HttpUrl.callCustomerStatusGetUrl,
      requestBodydata: {'id': callId},
    );
    if (postResult[Constants.success]) {
      if ((postResult['data']['result'] as List).isEmpty) {
        AppUtils.showToast('Wait few seconds, You\'ll get call from Admin');
        return false;
      } else {
        if (postResult['data']['result'][0]['status2'] == null) {
          if (postResult['data']['result'][0]['status'] == 'ANSWER') {
            AppUtils.showToast('Please wait for the call is ongoing');
          } else {
            // From Agent Doesn't Pick the Call
            AppUtils.showToast('Please Speak with customer');
          }
          return false;
        } else {
          AppUtils.showToast(
              'Call Status is ${postResult['data']['result'][0]['status2']}');
          return true;
        }
      }
    } else {
      return false;
    }
  }
}
