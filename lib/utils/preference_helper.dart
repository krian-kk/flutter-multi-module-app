// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static setPreference(String keyPair, dynamic argValues) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    await SharedPreferences.getInstance().then((value) {
      value.setString(
          keyPair,
          Encrypter(AES(Key.fromUtf8(deviceId!)))
              .encrypt(argValues.toString(), iv: IV.fromLength(16))
              .base16);
    });
  }

  static Future<String?> getString({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? temporaryValues = prefs.getString(keyPair);
    return temporaryValues == null
        ? ''
        : Encrypter(AES(Key.fromUtf8(deviceId!)))
            .decrypt16(temporaryValues, iv: IV.fromLength(16))
            .toString();
  }

  static Future<double?> getDouble({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? temporaryValues = prefs.getString(keyPair);
    return temporaryValues == null
        ? null
        : double.parse(Encrypter(AES(Key.fromUtf8(deviceId!)))
            .decrypt16(temporaryValues, iv: IV.fromLength(16)));
  }

  static Future<int?> getInt({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? temporaryValues = prefs.getString(keyPair);
    return temporaryValues == null
        ? null
        : int.parse(Encrypter(AES(Key.fromUtf8(deviceId!)))
            .decrypt16(temporaryValues, iv: IV.fromLength(16)));
  }

  static Future<bool> getBool({required String keyPair}) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? temporaryValues = prefs.getString(keyPair);
    final String booleanValues = temporaryValues == null
        ? 'false'
        : Encrypter(AES(Key.fromUtf8(deviceId!)))
            .decrypt16(temporaryValues, iv: IV.fromLength(16));
    return booleanValues.toLowerCase() == 'true';
  }
}
