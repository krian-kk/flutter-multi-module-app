import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_event.dart';
import 'bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (!DebugMode.isInDebugMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  }

  Bloc.observer = EchoBlocDelegate();
  runApp(
    EasyLocalization(
      child: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          return AuthenticationBloc()..add(AppStarted());
        },
        child: MyApp(),
      ),
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'AE')],
      path: "assets/translations",
      fallbackLocale: const Locale('en', 'US'),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.changeLanguage(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  late AuthenticationBloc bloc;
  Locale? _locale;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // context.setLocale(Locale('ar', 'AE'));
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorResource.color0066cc,
        statusBarBrightness: Brightness.light));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: ColorResource.color0066cc,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: getRoute,
      // ignore: prefer_double_quotes
      home: addAuthBloc(
        context,
        SplashScreen(),
      ),
    );
  }
}
