import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/http/dio_client.dart';
import 'package:origa/http/httpurls.dart';

enum APIRequestType { GET, POST, PUT, DELETE, UPLOAD, DOWNLOAD }

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
      {dynamic requestBodydata, List<File>? file, String? savePath}) async {
    Map<String, dynamic> returnValue;

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
            final FormData data = FormData.fromMap({
              'file': DioClient.listOfMultiPart(file),
            });
            response = await DioClient.dioConfig()
                .post(HttpUrl.fileUpload, data: data);
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
      returnValue = {'success': true, 'data': response!.data};
    } on DioError catch (e) {
      dynamic error;
      if (e.response != null) {
        error = DioClient.errorHandling(e);
      } else {
        error = 'Error sending request!';
      }
      debugPrint('urlString-->$urlString \n  requestBodydata-->$requestBodydata'
          '\n  response-->${jsonDecode(e.response.toString())}');
      returnValue = {'success': false, 'data': error};
    }

    return returnValue;
  }

  // get priority case list
  static Future<Map<String, dynamic>> getpriorityCaseList() async {
    dynamic? returnableValues;
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
    dynamic? returnableValues;
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
