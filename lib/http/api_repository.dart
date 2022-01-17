import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/http/dio_client.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/router.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum APIRequestType {
  GET,
  POST,
  PUT,
  DELETE,
  UPLOAD,
  DOWNLOAD,
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    try {
      Response? response;
      switch (requestType) {
        case APIRequestType.GET:
        case APIRequestType.DELETE:
          {
            response = requestType == APIRequestType.DELETE
                ? await DioClient.dioConfig().delete(urlString)
                : await DioClient.dioConfig().get(urlString);
            break;
          }
        case APIRequestType.UPLOAD:
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
        case APIRequestType.DOWNLOAD:
          {
            response = await DioClient.dioConfig().download(urlString, savePath,
                onReceiveProgress: onReceiveProgress);
            break;
          }
        case APIRequestType.PUT:
          {
            response = await DioClient.dioConfig().put(
              urlString,
              data: requestBodydata,
            );
            break;
          }
        case APIRequestType.POST:
        default:
          {
            response = await DioClient.dioConfig()
                .post(urlString, data: requestBodydata);
          }
      }
      debugPrint('urlString-->$urlString \n  requestBodydata-->$requestBodydata'
          '\n  response-->${jsonDecode(response.toString())}');
      // print('response data -------->');
      // print(response!.headers['access-token']);
      // print('response Headers -------->');

      if (response!.headers['access-token'] != null) {
        print('Here get New Access Token for every API call then store');
        print(response.headers['access-token']);
        // Here get New Access Token for every API call then store
        if (response.headers['access-token']![0].toString() != 'false') {
          _prefs.setString(Constants.accessToken,
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
      // print("-------NK------");
      // print(e.response!.statusCode);
      dynamic error;
      String? invalidAccessServerError;
      if (e.response != null) {
        error = DioClient.errorHandling(e);
      } else {
        // error =
        //     'Error sending request!'; // connection timeout sometime will come
        error = 'connection timeout'; // connection timeout sometime will come
      }
      debugPrint('urlString-->$urlString \n  requestBodydata-->$requestBodydata'
          '\n  response-->${jsonDecode(e.response.toString())}');
      print('response dio error data -------->');

      if (error.toString() != "DioErrorType.response") {
        // isPop is used for if i load new api then get any error then pop the back screen
        if (isPop == true) {
          Navigator.pop(Singleton.instance.buildContext!);
        }
        apiErrorStatus(
            ErrorString: error.toString(), position: ToastGravity.CENTER);
      }

      // if (e.response != null) {
      //   if (e.response!.statusCode == 502) {
      //     //  server not response so api not working
      //     invalidAccessServerError = Constants.internalServerError;
      //     apiErrorStatus(
      //         ErrorString: Constants.internalServerError,
      //         position: ToastGravity.BOTTOM);
      //   }
      // }

      if (e.response != null) {
        // print("---------------e.response!.data['message']");
        // print(e.response!.data['message']);
        // print(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          //  here check accestoken expire or not after go to login
          invalidAccessServerError =
              e.response!.data['message'] ?? "Session Expired!";
          String? errVal;
          if (e.response!.data['message'] ==
                  'Error refreshing access token: Invalid refresh token' ||
              e.response!.data['message'] == 'Error getting KeyCloak session' ||
              e.response!.data['message'] == 'Daily token session expired' ||
              e.response!.data['message'] ==
                  'Access token invalid and no refresh token provided' ||
              e.response!.data['message'] ==
                  'Error refreshing access token: Session not active' ||
              invalidAccessServerError == 'Session Expired!') {
            errVal = "Logout triggered due to inactivity / another";
            Navigator.pushNamedAndRemoveUntil(Singleton.instance.buildContext!,
                AppRoutes.loginScreen, (route) => false);
          }
          //  else {
          //   errVal = e.response!.data['message'];
          // }
          apiErrorStatus(
              ErrorString: errVal ?? e.response!.data['message'],
              position: ToastGravity.BOTTOM);
          // if (e.response!.data['message'] ==
          //         'Error refreshing access token: Invalid refresh token' ||
          //     e.response!.data['message'] == 'Error getting KeyCloak session' ||
          //     e.response!.data['message'] == 'Daily token session expired' ||
          //     e.response!.data['message'] ==
          //         'Error refreshing access token: Session not active' ||
          //     invalidAccessServerError == 'Session Expired!') {
          //   // AuthenticationBloc bloc;
          //   // bloc = AuthenticationBloc()..add(UnAuthenticationEvent());
          //   Navigator.pushNamedAndRemoveUntil(Singleton.instance.buildContext!,
          //       AppRoutes.loginScreen, (route) => false);
          // }
        } else if (e.response!.statusCode == 502) {
          //  server not response --> api not working
          invalidAccessServerError = Constants.internalServerError;
          apiErrorStatus(
              ErrorString: Constants.internalServerError,
              position: ToastGravity.BOTTOM);
        } else if (e.response!.statusCode == 400) {
          //Event address not present
          apiErrorStatus(
              ErrorString: e.response!.data['message'] ?? '',
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
        'data': invalidAccessServerError != null
            ? invalidAccessServerError
            : e.response != null
                ? e.response!.data
                : error,
        'statusCode': e.response != null ? e.response!.statusCode : '',
      };
    }

    return returnValue;
  }

  static void apiErrorStatus({String? ErrorString, ToastGravity? position}) {
    Fluttertoast.showToast(
        msg: ErrorString!,
        toastLength: Toast.LENGTH_LONG,
        gravity: position ?? ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: ColorResource.color101010,
        textColor: ColorResource.colorffffff,
        fontSize: 14.0);
  }

  // get priority case list
  static Future<Map<String, dynamic>> getpriorityCaseList() async {
    dynamic returnableValues;
    try {
      final Response response = await DioClient.dioConfig().get(
        HttpUrl.priorityCaseList,
      );
      // print('response.data: ${response.data}');
      // returnableValues = PriorityCaseListModel.fromJson(response.data);
      // returnableValues = json.decode(response.toString());
      returnableValues = response.data;
      // print(returnableValues);
    } on DioError catch (e) {
      if (e.response != null) {
        returnableValues = DioClient.errorHandling(e);
      } else {
        print(e.message);
        returnableValues = 'Error sending request!';
      }
    }
    return returnableValues;
  }

  // get buildroute case list
  static Future<Map<String, dynamic>> getBuildRouteCaseList() async {
    dynamic returnableValues;
    try {
      final Response response = await DioClient.dioConfig().get(
        HttpUrl.buildRouteCaseList,
      );
      returnableValues = response.data;
      // print(returnableValues);
    } on DioError catch (e) {
      if (e.response != null) {
        returnableValues = DioClient.errorHandling(e);
      } else {
        print(e.message);
        returnableValues = 'Error sending request!';
      }
    }
    return returnableValues;
  }

  // // get CaseDetails Api List Data
  // static Future<Map<String, dynamic>> getCaseDetailsData(String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.caseDetailsUrl + id,
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // // get Build Route Data
  // static Future<Map<String, dynamic>> getBuildRouteList(
  //     String lat, String lan, String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.buildRouteUrl + '5000',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // // get Profile Data
  // static Future<Map<String, dynamic>> getProfileData(String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.profileUrl + id,
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // // get Event Details Api Data
  // static Future<Map<String, dynamic>> getEventDetailsData(String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.eventDetailsUrl + id,
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // // Dashboard Proirity Follow Up
  // static Future<Map<String, dynamic>> getDashboardProirityFollowUpData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardPriorityProirityFollowUpUrl + '411036',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // //Dashboard Broken PTP
  // static Future<Map<String, dynamic>> getDashboardBrokenPTPData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardBrokenPTPUrl + '10',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // // Dashboard Untouched Cases
  // static Future<Map<String, dynamic>> getDashboardUntouchedCasesData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardUntouchedCasesUrl + '',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // //Dashboard My Visits
  // static Future<Map<String, dynamic>> getDashboardMyVisitsData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardMyVisitsUrl + '',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // //Dashboard My Receipts
  // static Future<Map<String, dynamic>> getDashboardMyReceiptsData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardMyVisitsUrl + '',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // //Dashboard My Deposits
  // static Future<Map<String, dynamic>> getDashboardMyDeposistsData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardMyDeposistsUrl + 'WEEKLY',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // //Dashboard Yarding And Self Release Data
  // static Future<Map<String, dynamic>> getDashboardYardingAndSelfReleaseData(
  //     String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.dashboardYardingAndSelfReleaseUrl + '5f80375a86527c46deba2e60',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

  // //Dashboard Search Data
  // static Future<Map<String, dynamic>> getSearchData(String id) async {
  //   try {
  //     final Response response = await DioClient.dioConfig().get(
  //       HttpUrl.searchUrl + 'MOR000800314934',
  //     );
  //     return {'success': true, 'data': response.data};
  //   } on DioError catch (e) {
  //     dynamic error;
  //     if (e.response != null) {
  //       error = DioClient.errorHandling(e);
  //     } else {
  //       error = 'Error sending request!';
  //     }
  //     return {'success': false, 'data': error};
  //   }
  // }

//   //File uploading---> File, Image etc
//   //File data should be list model if you're sending single or more
//   Future<dynamic> multipartFileUpload(
//       {List<File>? file, String? urlString}) async {
//     dynamic? returnableValues;
//     final FormData data = FormData.fromMap({
//       'file': DioClient.listOfMultiPart(file),
//     });
//     try {
//       final Response response =
//           await DioClient.dioConfig().post(HttpUrl.fileUpload, data: data);
//       returnableValues = response.data;
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   // Downloading the file with progress update
//   Future<dynamic> downloadFile({String? urlString, String? savePath}) async {
//     dynamic? returnableValues;
//     // Like saved path should be covered by permission handler and with writing path
//     //Example
//     /* if (isPermissionStatusGranted) {
//       final savePath = path.join(dir.path, _fileName);
//       await downloadFile(url,savePath);
//     }
//      */
//     try {
//       final response = await DioClient.dioConfig()
//           .download(urlString, savePath, onReceiveProgress: onReceiveProgress);
//       returnableValues = response;
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   //Get methods with or without path name and dynamic return type
//   Future<dynamic?> getUser({required String id}) async {
//     dynamic? returnableValues;
//     try {
//       final Response response =
//           await DioClient.dioConfig().get(HttpUrl.getUserProfile + '/$id');
//       print('response Data: ${response.data}');
//       returnableValues = response.data;
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

// // get country codes
//   Future<dynamic?> getCountryCodes() async {
//     dynamic? returnableValues;
//     try {
//       final Response response = await DioClient.dioConfig().get(
//         HttpUrl.getCountryCodes,
//       );
//       print('response.data: ${response.data}');
//       // returnableValues = CountryCodeModel.fromJson(response.data);
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   //Post methods with or without parameters and dynamic return type
//   Future<dynamic?> registerUser(dynamic userInfo) async {
//     dynamic? returnableValues;
//     try {
//       final Response response = await DioClient.dioConfig().post(
//         HttpUrl.register,
//         data: userInfo,
//       );
//       print('response.data: ${response.data}');
//       // returnableValues = UserSignUpModel.fromJson(response.data);
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   //Post method Login User
//   Future<dynamic?> loginUser(dynamic userInfo) async {
//     dynamic? returnableValues;
//     try {
//       final Response response = await DioClient.dioConfig().post(
//         HttpUrl.register,
//         data: userInfo,
//       );
//       print('response.data: ${response.data}');
//       // returnableValues = LoginUserResponseModel.fromJson(response.data);
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   Future<dynamic?> otpValidation(dynamic otpDetails) async {
//     dynamic? returnableValues;
//     try {
//       final Response response = await DioClient.dioConfig().post(
//         HttpUrl.otpValidate,
//         data: otpDetails,
//       );
//       print('response.data: ${response.data}');
//       // returnableValues = OtpValidationModel.fromJson(response.data);
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   //Put methods with or without path name and dynamic parameter and return type
//   Future<dynamic?> updateProfile({dynamic? userInfo, String? id}) async {
//     dynamic? returnableValues;
//     try {
//       final response = await DioClient.dioConfig().put(
//         HttpUrl.editUserProfile + '/$id',
//         data: userInfo!.toJson(),
//       );
//       print('response.data: ${response.data}');
//       returnableValues = response.data;
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }

//   //delete methods with or without path name and dynamic parameter and return type
//   Future<dynamic> deleteProfile({required String id}) async {
//     dynamic? returnableValues;
//     try {
//       final Response response = await DioClient.dioConfig()
//           .delete(HttpUrl.deleteUserProfile + '/$id');
//       print('response.data: ${response.data}');
//       returnableValues = response.data;
//     } on DioError catch (e) {
//       if (e.response != null) {
//         returnableValues = DioClient.errorHandling(e);
//       } else {
//         print(e.message);
//         returnableValues = 'Error sending request!';
//       }
//     }
//     return returnableValues;
//   }
}
