import 'package:flutter/material.dart';
import 'package:languages/language_config.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/src/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpUrl.loadValue('poc');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Collect',
      routerConfig: AppRouter().router,
      locale: _locale,
      supportedLocales: LanguageConfigs.listOfSupportedLanguages,
      localizationsDelegates: LanguageConfigs.listOfLocalizationsDelegates,
      localeResolutionCallback: LanguageConfigs.localeResolutionCallback,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Lato-Regular',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FB),
        ),
      ),
    );
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
