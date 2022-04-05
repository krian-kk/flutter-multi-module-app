import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/http/dio_client.dart';
import 'package:origa/router.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum APIRequestType {
  get,
  post,
  put,
  delete,
  upload,
  download,
  singleFileUpload
}

class APIRepository {
  //Progress sample model
  static void onReceiveProgress(int received, int total) {
    if (total != -1) {
      /*setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });*/
    }
  }

  static Future<Map<String, dynamic>> apiRequest(
      APIRequestType requestType, String urlString,
      {dynamic requestBodydata,
      List<File>? file,
      File? imageFile,
      FormData? formDatas,
      String? savePath,
      bool isPop = false}) async {
    Map<String, dynamic> returnValue;
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    debugPrint(
        'Initial -> urlString-->$urlString \n  requestBodydata-->$requestBodydata}');

    try {
      Response? response;
      switch (requestType) {
        case APIRequestType.get:
        case APIRequestType.delete:
          {
            response = requestType == APIRequestType.delete
                ? await DioClient.dioConfig().delete(urlString)
                : await DioClient.dioConfig().get(urlString);
            break;
          }
        case APIRequestType.upload:
          {
            // final FormData data = FormData.fromMap({
            //   'files': DioClient.listOfMultiPart(file),
            // });
            response = await DioClient.dioFileConfig()
                .post(urlString, data: formDatas);
            break;
          }
        case APIRequestType.singleFileUpload:
          {
            final FormData data = FormData.fromMap(
                {'file': await MultipartFile.fromFile(imageFile!.path)});
            response =
                await DioClient.dioFileConfig().post(urlString, data: data);
            break;
          }
        case APIRequestType.download:
          {
            response = await DioClient.dioConfig().download(urlString, savePath,
                onReceiveProgress: onReceiveProgress);
            break;
          }
        case APIRequestType.put:
          {
            response = await DioClient.dioConfig().put(
              urlString,
              data: requestBodydata,
            );
            break;
          }
        case APIRequestType.post:
        default:
          {
            response = await DioClient.dioConfig()
                .post(urlString, data: requestBodydata);
          }
      }
      debugPrint('urlString-->$urlString \n  requestBodydata-->$requestBodydata'
          '\n  response-->${jsonDecode(response.toString())}');

      if (response!.headers['access-token'] != null) {
        debugPrint('Access Token is => ${response.headers['access-token']}');
        // Here get New Access Token for every API call then store
        if (response.headers['access-token']![0].toString() != 'false') {
          await _prefs.setString(Constants.accessToken,
              response.headers['access-token']![0].toString());
          Singleton.instance.accessToken =
              response.headers['access-token']![0].toString();
        }
      }

      returnValue = {
        'success': true,
        'data': response.data,
        'statusCode': response.data['status'],
      };
    } on DioError catch (e) {
      dynamic error;
      String? invalidAccessServerError;
      if (e.response != null) {
        error = DioClient.errorHandling(e);
      } else {
        // error =
        //     'Error sending request!'; // connection timeout sometime will come
        error = Constants
            .connectionTimeout; // connection timeout sometime will come
      }

      debugPrint(
          'Error Status :  urlString-->$urlString \n  requestBodydata-->$requestBodydata'
          '\n  response-->${jsonDecode(e.response.toString())}');

      if (error.toString() != 'DioErrorType.response') {
        // isPop is used for if i load new api then get any error then pop the back screen
        if (isPop == true) {
          Navigator.pop(Singleton.instance.buildContext!);
        }
        apiErrorStatus(
            errorString: error.toString(), position: ToastGravity.CENTER);
      }

      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          //  here check accestoken expire or not after go to login
          invalidAccessServerError =
              e.response!.data['message'] ?? 'Session Expired!';
          String? errVal;
          if (e.response!.data['message'] ==
                  'Error refreshing access token: Invalid refresh token' ||
              e.response!.data['message'] == 'Error getting KeyCloak session' ||
              e.response!.data['message'] ==
                  'Error refreshing access token: Token is not active' ||
              e.response!.data['message'] == 'Daily token session expired' ||
              e.response!.data['message'] ==
                  'Access token invalid and no refresh token provided' ||
              e.response!.data['message'] ==
                  'Error refreshing access token: Session not active' ||
              invalidAccessServerError == 'Session Expired!') {
            errVal = 'Logout triggered due to inactivity / another';

            await Navigator.pushNamedAndRemoveUntil(
                Singleton.instance.buildContext!,
                AppRoutes.loginScreen,
                (route) => false);
          }
          apiErrorStatus(
              errorString: errVal ?? e.response!.data['message'],
              position: ToastGravity.BOTTOM);
        } else if (e.response!.statusCode == 502) {
          //  server not response --> api not working
          invalidAccessServerError = Constants.internalServerError;
          apiErrorStatus(
              errorString: Constants.internalServerError,
              position: ToastGravity.BOTTOM);
        } else if (e.response!.statusCode == 400) {
          //Event address not present
          apiErrorStatus(
              errorString: e.response!.data['message'] ?? '',
              position: ToastGravity.BOTTOM);
        }
      }

      // returnValue = {
      //   'success': false,
      //   'data': error,
      //   'statusCode': e.response!.statusCode ?? ''
      // };

      returnValue = {
        'success': false,
        'data': (invalidAccessServerError != null)
            ? invalidAccessServerError
            : e.response != null
                ? e.response!.data
                : error,
        'statusCode': e.response != null ? e.response!.statusCode : '',
      };
    }

    return returnValue;
  }

  static void apiErrorStatus({String? errorString, ToastGravity? position}) {
    Fluttertoast.showToast(
        msg: errorString!,
        toastLength: Toast.LENGTH_LONG,
        gravity: position ?? ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: ColorResource.color101010,
        textColor: ColorResource.colorffffff,
        fontSize: 14.0);
  }
}
