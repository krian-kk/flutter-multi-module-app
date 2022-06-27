// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  // static const storage = FlutterSecureStorage();

  static setPreference(String keyPair, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    // /* value = Encrypter(AES(Key.fromUtf8(deviceId!)))
    //     .encrypt(value.toString(), iv: IV.fromLength(16))
    //     .toString();*/
    //
    // value = Encrypter(AES(Key.fromUtf8(deviceId!)))
    //     .encrypt(value.toString(), iv: IV.fromLength(16));

    if (value is bool) {
      await prefs.setBool(keyPair, value);
    }
    if (value is int) {
      await prefs.setInt(keyPair, value);
    }
    if (value is double) {
      await prefs.setDouble(keyPair, value);
    }
    if (value is String) {
      await prefs.setString(keyPair, value);
    }
    if (kDebugMode) {
      print('KeyValues--> $keyPair --> values--> $value');
    }
  }

  static Future<String?> getString({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPair);
    // return Encrypter(AES(Key.fromUtf8(deviceId!)))
    //     .encrypt(prefs.getString(keyPair).toString(), iv: IV.fromLength(16))
    //     .toString();
  }

  static Future<double?> getDouble({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(keyPair);
    // return double.parse(Encrypter(AES(Key.fromUtf8(deviceId!)))
    //     .encrypt(prefs.getDouble(keyPair).toString(), iv: IV.fromLength(16))
    //     .toString());
  }

  static Future<int?> getInt({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyPair);
    // return int.parse(Encrypter(AES(Key.fromUtf8(deviceId!)))
    //     .encrypt(prefs.getDouble(keyPair).toString(), iv: IV.fromLength(16))
    //     .toString());
  }

  static Future<bool> getBool({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyPair) ?? false;
    // return Encrypter(AES(Key.fromUtf8(deviceId!)))
    //     .encrypt(prefs.getDouble(keyPair).toString(), iv: IV.fromLength(16))
    //     .toString() as bool;
  }
}
