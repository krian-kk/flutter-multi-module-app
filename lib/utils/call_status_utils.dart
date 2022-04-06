import 'package:flutter/material.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';

class CallCustomerStatus {
  CallCustomerStatus._();

  static Future<bool> callStatusCheck(
      {required String callId, required BuildContext context}) async {
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.callCustomerStatusGetUrl,
      requestBodydata: <String, dynamic>{'id': callId},
    );
    if (postResult[Constants.success]) {
      if ((postResult['data']['result'] as List<dynamic>).isEmpty) {
        AppUtils.showToast(
            Languages.of(context)!.waitFewSecondsYouGetCallFromAdmin);
        return false;
      } else {
        if (postResult['data']['result'][0]['status2'] == null) {
          if (postResult['data']['result'][0]['status'] == 'ANSWER') {
            AppUtils.showToast(
                Languages.of(context)!.pleaseWaitForTheCallIsOngoing);
          } else {
            // From Agent Doesn't Pick the Call
            AppUtils.showToast(Languages.of(context)!.pleaseSpeakWithCustomer);
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

  /* if agent doesn't get the call from VOIP -> after 30 seconds it'll
    move next index of number (maybe next case or nex number of current case)  */
  static Future<bool> callStatusCheckForAutoJump(
      {required String callId, required BuildContext context}) async {
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.callCustomerStatusGetUrl,
      requestBodydata: <String, dynamic>{'id': callId},
    );
    if (postResult[Constants.success]) {
      return (postResult['data']['result'] as List<dynamic>).isEmpty;
    } else {
      return false;
    }
  }
}
