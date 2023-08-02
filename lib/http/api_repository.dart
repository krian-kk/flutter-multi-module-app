import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/http/dio_client.dart';
import 'package:origa/router.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:preference_helper/preference_helper.dart';

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

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  static Future<Map<String, dynamic>> apiRequest(
      APIRequestType requestType, String urlString,
      {dynamic requestBodydata,
      List<File>? file,
      File? imageFile,
      FormData? formDatas,
      String? savePath,
      bool isPop = false,
      bool encrypt = false,
      bool decryptResponse = true}) async {
    Map<String, dynamic> returnValue;

    try {
      Response<dynamic>? response;
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
            response = await DioClient.dioFileConfig().post(urlString, data: formDatas);
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
      if (response!.headers['access-token'] != null) {
        // Here get New Access Token for every API call then store
        if (response.headers['access-token']![0].toString() != 'false') {
          await PreferenceHelper.setPreference(Constants.accessToken,
              response.headers['access-token']![0].toString());
          // Singleton.instance.accessToken =
          //     response.headers['access-token']![0].toString();
        }
      }
      if (encrypt && response.data['status'] == 200) {
        final Map<String, dynamic> requestData = {
          'data': response.data['result']
        };
        if(decryptResponse){
          String text = await platform.invokeMethod('getDecryptedData', requestData);
          response.data['result'] = json.decode(text);
        }

        return {
          'success': true,
          'data': response.data,
          'statusCode': response.data['status'],
        };
      }
      returnValue = (response.data['status'] == 400)
          ? {
              'success': false,
              'data': response.data['msg'],
              'statusCode': response.data['status'],
            }
          : {
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

      if (error.toString() != 'DioErrorType.response') {
        // isPop is used for if i load new api then get any error then pop the back screen
        if (isPop == true) {
          Navigator.pop(Singleton.instance.buildContext!);
        }
        // apiErrorStatus(
        //     errorString: error.toString(), position: ToastGravity.CENTER);
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
            try {
              if (Navigator.canPop(Singleton.instance.buildContext!)) {
                await Navigator.pushReplacementNamed(
                    Singleton.instance.buildContext!, AppRoutes.loginScreen);
              } else {
                await Navigator.pushNamed(
                    Singleton.instance.buildContext!, AppRoutes.loginScreen);
              }
            } on DioError catch (e) {}
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
    if (errorString != '') {
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
}
