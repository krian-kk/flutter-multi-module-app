import 'dart:convert';

import 'package:cross_platform_crypto/cross_platform_crypto.dart';
import 'package:dio/dio.dart';
import 'package:network_helper/dio/dio_client.dart';

extension CryptoHelper on CrossPlatformCrypto {
  Future<dynamic> extractResponse(
      bool decryptResponse, Response<dynamic> response) async {
    if (response.data[keyStatus] == httpCode200 && decryptResponse) {
      final Map<String, dynamic> responseData = {
        keyData: response.data[keyResult]
      };
      String text = await getDecryptedData(responseData) ?? '';
      response.data[keyResult] = json.decode(text);
    }
    return response.data;
  }

  dynamic checkForRequestBody(bool encryptRequestBody, data) async {
    if (encryptRequestBody) {
      final Map<String, dynamic> requestData = {
        keyData: jsonEncode(data),
      };
      String encryptedText = '';
      encryptedText = await sendEncryptedData(requestData) ?? '';
      return {keyEncryptedData: encryptedText};
    } else {
      return data;
    }
  }
}
