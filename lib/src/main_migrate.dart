import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_locale_constant.dart';
import 'package:origa/languages/app_localizations_delegate.dart';
import 'package:origa/src/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpUrl.loadValue('poc');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Collect',
      routerConfig: AppRouter().router,
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
        Locale('ta', ''),
        Locale('id', ''),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Lato-Regular',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FB),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    getLocale().then((Locale locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }
}
