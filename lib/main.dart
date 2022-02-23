import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_locale_constant.dart';
import 'package:origa/languages/app_localizations_delegate.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_theme.dart';
import 'package:origa/widgets/custom_loading_widget.dart';

import 'authentication/authentication_bloc.dart';
import 'bloc.dart';

void main() {
  Bloc.observer = EchoBlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) {
        return AuthenticationBloc()..add(AppStarted(context: context));
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  AuthenticationBloc? bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
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

  //Getting firebase remote data for app URL
  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    await Firebase.initializeApp();
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.fetchAndActivate();
    //development = 1, uat = 2, production = 3
    try {
      HttpUrl.url = Singleton.instance.serverPointingType == 1
          ? HttpUrl.url =
              remoteConfig.getString('v1_development_mobile_app_baseUrl')
          : Singleton.instance.serverPointingType == 2
              ? HttpUrl.url =
                  remoteConfig.getString('v1_uat_mobile_app_baseUrl')
              : HttpUrl.url =
                  remoteConfig.getString('v1_production_mobile_app_baseUrl');
      debugPrint('URL -> ${HttpUrl.url}');
    } catch (e) {
      debugPrint('Catch-> $e');
      setupRemoteConfig();
    }
    return remoteConfig;
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: AppThemes().getThemeCollections(),
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('hi', ''),
            Locale('ta', '')
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
          onGenerateRoute: getRoute,
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
              future: setupRemoteConfig(),
              builder: (context, snapshot) {
                if (snapshot.hasError && HttpUrl.url != '') {
                  return Container(
                    child: const CustomLoadingWidget(),
                    alignment: Alignment.center,
                  );
                } else {
                  return addAuthBloc(
                    context,
                    const SplashScreen(),
                  );
                }
              }),
        );
      },
    );
  }
}
