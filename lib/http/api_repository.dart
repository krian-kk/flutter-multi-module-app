import 'dart:io';
import 'package:dio/dio.dart';
import 'package:origa/http/dio_client.dart';
import 'package:origa/http/httpurls.dart';

class APIRepository {
  //File uploading---> File, Image etc
  //File data should be list model if you're sending single or more
  Future<dynamic> multipartFileUpload(
      {List<File>? file, String? urlString}) async {
    dynamic? returnableValues;
    final FormData data = FormData.fromMap({
      'file': DioClient.listOfMultiPart(file),
    });
    try {
      final Response response =
          await DioClient.dioConfig().post(HttpUrl.fileUpload, data: data);
      returnableValues = response.data;
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

  //Progress sample model
  void onReceiveProgress(int received, int total) {
    if (total != -1) {
      /*setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });*/
    }
  }

  // Downloading the file with progress update
  Future<dynamic> downloadFile({String? urlString, String? savePath}) async {
    dynamic? returnableValues;
    // Like saved path should be covered by permission handler and with writing path
    //Example
    /* if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      await downloadFile(url,savePath);
    }
     */
    try {
      final response = await DioClient.dioConfig()
          .download(urlString, savePath, onReceiveProgress: onReceiveProgress);
      returnableValues = response;
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

  //Get methods with or without path name and dynamic return type
  Future<dynamic?> getUser({required String id}) async {
    dynamic? returnableValues;
    try {
      final Response response =
          await DioClient.dioConfig().get(HttpUrl.getUserProfile + '/$id');
      print('response Data: ${response.data}');
      returnableValues = response.data;
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
// get country codes
  Future<dynamic?> getCountryCodes() async {
    dynamic? returnableValues;
    try {
      final Response response = await DioClient.dioConfig().get(
        HttpUrl.getCountryCodes,
      );
      print('response.data: ${response.data}');
      // returnableValues = CountryCodeModel.fromJson(response.data);
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

  //Post methods with or without parameters and dynamic return type
  Future<dynamic?> registerUser(dynamic userInfo) async {
    dynamic? returnableValues;
    try {
      final Response response = await DioClient.dioConfig().post(
        HttpUrl.register,
        data: userInfo,
      );
      print('response.data: ${response.data}');
      // returnableValues = UserSignUpModel.fromJson(response.data);
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

  //Post method Login User
  Future<dynamic?> loginUser(dynamic userInfo) async {
    dynamic? returnableValues;
    try {
      final Response response = await DioClient.dioConfig().post(
        HttpUrl.register,
        data: userInfo,
      );
      print('response.data: ${response.data}');
      // returnableValues = LoginUserResponseModel.fromJson(response.data);
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

  Future<dynamic?> otpValidation(dynamic otpDetails) async {
    dynamic? returnableValues;
    try {
      final Response response = await DioClient.dioConfig().post(
        HttpUrl.otpValidate,
        data: otpDetails,
      );
      print('response.data: ${response.data}');
      // returnableValues = OtpValidationModel.fromJson(response.data);
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

  //Put methods with or without path name and dynamic parameter and return type
  Future<dynamic?> updateProfile({
    dynamic? userInfo,
    String? id,
  }) async {
    dynamic? returnableValues;
    try {
      final response = await DioClient.dioConfig().put(
        HttpUrl.editUserProfile + '/$id',
        data: userInfo!.toJson(),
      );
      print('response.data: ${response.data}');
      returnableValues = response.data;
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

  //delete methods with or without path name and dynamic parameter and return type
  Future<dynamic> deleteProfile({required String id}) async {
    dynamic? returnableValues;
    try {
      final Response response = await DioClient.dioConfig()
          .delete(HttpUrl.deleteUserProfile + '/$id');
      print('response.data: ${response.data}');
      returnableValues = response.data;
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
}
