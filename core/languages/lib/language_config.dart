import 'package:flutter/widgets.dart';
import 'package:languages/app_localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LanguageConfigs {
  static Iterable<LocalizationsDelegate<dynamic>> listOfLocalizationsDelegates =
      [
    const AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  static Iterable<Locale> listOfSupportedLanguages = const [
    Locale('en', ''),
    Locale('hi', ''),
    Locale('ta', ''),
    Locale('id', ''),
  ];

  static LocaleResolutionCallback localeResolutionCallback =
      (Locale? locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  };
}
