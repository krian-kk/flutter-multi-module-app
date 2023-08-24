import 'package:flutter/material.dart';
import 'package:origa/src/main_migrate.dart';
import 'package:origa/utils/preference_helper.dart';

const String prefSelectedLanguageCode = 'SelectedLanguageCode';

Future<Locale> setLocale(String languageCode) async {
  await PreferenceHelper.setPreference(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String? languageCode;
  await PreferenceHelper.getString(keyPair: prefSelectedLanguageCode)
      .then((value) {
    languageCode = value;
  });
  return _locale(languageCode!);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale('en', '');
}

changeLanguage(BuildContext context, String selectedLanguageCode) async {
  print(selectedLanguageCode);
  final Locale _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
}
