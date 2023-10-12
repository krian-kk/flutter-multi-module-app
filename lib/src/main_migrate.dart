import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages/app_locale_constant.dart';
import 'package:languages/language_config.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/src/locale/locale_cubit.dart';
import 'package:origa/src/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpUrl.loadValue('poc');
  runApp(BlocProvider(
    create: (context) => LocaleCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return MaterialApp.router(
          title: 'Collect',
          routerConfig: AppRouter().router,
          locale: localeState.locale,
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
      },
    );
  }

  @override
  void didChangeDependencies() {
    getLocale().then((Locale locale) {
      BlocProvider.of<LocaleCubit>(context).changeLang(locale.languageCode);
    });
    super.didChangeDependencies();
  }
}
