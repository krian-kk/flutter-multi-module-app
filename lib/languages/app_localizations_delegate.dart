import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/languages/language_bahasa.dart';
import 'package:origa/languages/language_hindi.dart';

import 'language_english.dart';
import 'language_tamil.dart';
import 'language_bahasa.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'hi', 'ta', 'id'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'hi':
        return LanguageHi();
      case 'ta':
        return LanguageTa();
      case 'id':
        return LanguageBa();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
