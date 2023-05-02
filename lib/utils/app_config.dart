import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  AppConfig({required this.baseUrl, required this.apiType});

  final String baseUrl;
  final String apiType;

  static Future<AppConfig> forEnvironment(String env) async {
    // load the json file
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    // decode our json
    final json = jsonDecode(contents);

    // convert our JSON into an instance of our AppConfig class
    return AppConfig(baseUrl: json['base_url'], apiType: json['api_type']);
  }
}
