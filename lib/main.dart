import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_locale_constant.dart';
import 'package:origa/languages/app_localizations_delegate.dart';
import 'package:origa/models/notification_data_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';
import 'package:origa/utils/app_theme.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'authentication/authentication_bloc.dart';
import 'bloc.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;
// local notification integration
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AuthenticationBloc bloc;

void main() async {
  bloc = AuthenticationBloc();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// Requesting Push Notification Permission
  requestNotificationPermission();

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

void requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //User granted permission
  } else {
    openAppSettings();
  }
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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale? _locale;
  AuthenticationBloc? bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AuthenticationBloc>(context);
    androidAndIOSNotification();

    // Background Notification onclick process
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        NotificationDataModel notificationData = NotificationDataModel();
        try {
          notificationData = NotificationDataModel.fromJson(message.data);
        } catch (e) {
          // debugPrint(e.toString());
        }
        bloc!.add(AppStarted(
            context: context,
            notificationData: notificationData.typeOfNotification ??
                message.data['typeOfNotification']));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationDataModel notificationData = NotificationDataModel();
      try {
        notificationData = NotificationDataModel.fromJson(message.data);
      } catch (e) {
        // debugPrint(e.toString());
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? iOS = message.notification?.apple;
      // debugPrint('Notification print-> ${notification!.title}');
      // debugPrint('notification!.body-> ${notification.body}');
      // listen and Show notification message
      if (Platform.isAndroid) {
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
              ),
            ),
            payload: notificationData.typeOfNotification,
          );
        }
      } else if (Platform.isIOS) {
        if (notification != null && iOS != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(),
            payload: notificationData.typeOfNotification,
          );
        }
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      debugPrint(
          'A new onMessageOpenedApp published!... -----> ${message.data}');
      bloc!.add(
          AppStarted(context: context, notificationData: notification!.body));
    });
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    // debugPrint("Handling a background message: ${message.messageId}");
  }

  void androidAndIOSNotification() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      "origa.ai", // title
      importance: Importance.high,
    );
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: forgroundOnClickNotification);

    /// Create an Android Notification Channel.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future forgroundOnClickNotification(String? payload) async {
    //Handle notification tapped logic here
    bloc!.add(AppStarted(context: context, notificationData: payload));
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    try {
      if (state != AppLifecycleState.resumed) {
        FirebaseFirestore.instance.disableNetwork();
      } else {
        FirebaseFirestore.instance.enableNetwork();
      }
    } catch (error) {
      debugPrint(
        'LifecycleManager | didChangeAppLifecycleState | ' + error.toString(),
      );
    }
  }

  //Getting firebase remote data for app URL
  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    await Firebase.initializeApp();
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // remoteConfig.fetchAndActivate();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    //development = 1, uat = 2, production = 3
    // try {
    //   HttpUrl.url = Singleton.instance.serverPointingType == 1
    //       ? HttpUrl.url =
    //           remoteConfig.getString('v1_development_mobile_app_baseUrl')
    //       : Singleton.instance.serverPointingType == 2
    //           ? HttpUrl.url =
    //               remoteConfig.getString('v1_uat_mobile_app_baseUrl')
    //           : HttpUrl.url =
    //               remoteConfig.getString('v1_production_mobile_app_baseUrl');
    //   // debugPrint('URL -> ${HttpUrl.url}');
    //   // var userID = md5.convert(utf8.encode("CDE_26")).toString();
    //   // debugPrint('user ID--> $userID');
    //   SharedPreferences _prefs = await SharedPreferences.getInstance();
    //   Singleton.instance.agentRef = _prefs.getString(Constants.agentRef);
    // } catch (e) {
    //   debugPrint('Catch-> $e');
    //   setupRemoteConfig();
    // }
    return remoteConfig;
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: AppThemes().getThemeCollections(),
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
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
                if (snapshot.hasError || HttpUrl.url.isEmpty) {
                  return Container(
                    color: Colors.white,
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
