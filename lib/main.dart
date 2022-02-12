import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:origa/languages/app_locale_constant.dart';
import 'package:origa/languages/app_localizations_delegate.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';
import 'package:origa/utils/app_theme.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_event.dart';
import 'bloc.dart';

void main() async {
  //Android //fiEaVaAARcuPY9m3M8nC4j:APA91bFr42QhThEzJZf4AvJjll8mV6pB59pMwSW_tu9mkSdDJzTu1nrkclyh1J_WJPdujmzf0ixFJdN25eJvEZp2hX96Fg9x0Iw7pJRbAyOPzzrFgA3tTUqD4GkLSuJSnORvTX_PgraR
  //iOS //eex9QKjyVkQdqd95EItHgp:APA91bF3W606FW5ZO9bldHYSCBhoZXex4z0TD24IRqy0840xBZ8YIw-2E-yib1Dg3fAwQDXfRaT6UfOcX-Zu8J3LhOzGVQ5TyyVFruZlEKofKXj0ddmGO9cb3qNyO3Orrpsj6GI_EGuQ
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint('Handling a background message ID ${message.messageId}');
    debugPrint(
        'Handling a background message Title ${message.notification!.title}');
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = EchoBlocDelegate();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (BuildContext context) {
      return AuthenticationBloc()..add(AppStarted(context: context));
    },
    child: const MyApp(),
  ));
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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'When the app opened via clicked notification--> ${message.notification!.title}');
    });
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
          home: addAuthBloc(
            context,
            const SplashScreen(),
          ),
        );
      },
    );
  }
}
