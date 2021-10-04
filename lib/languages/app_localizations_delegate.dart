import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'language_arabic.dart';
import 'language_english.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'hi' /*, 'ar', 'hi'*/].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      /*  case 'ar':
        return LanguageAr();
      case 'hi':
        return LanguageHi();*/
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
