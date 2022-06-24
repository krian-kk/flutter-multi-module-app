// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  // static const storage = FlutterSecureStorage();

  static setPreference(String keyPair, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
  }

  static Future<String> getString({required String keyPair}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(keyPair).toString();
  }

  static Future<double> getDouble({required String keyPair}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return double.parse(prefs.get(keyPair).toString());
  }

  static Future<int> getInt({required String keyPair}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return int.parse(prefs.get(keyPair).toString());
  }

  static Future<bool> getBool({required String keyPair}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(keyPair) as bool;
  }

  static Future<dynamic> getPreference(String keyPair) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(keyPair);
  }
// static Future<String> getStringPreferenceValue(String keyPair) async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString(keyPair) ?? '';
// }

// // Set Biometric authentication

// static void setBioMetricValue(String value) {
//   storage.write(key: Constants.bioMetricLogin, value: value);
// }

}
