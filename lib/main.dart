import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:freerasp/talsec_app.dart';
import 'package:origa/authentication/authentication_event.dart';
import 'package:origa/languages/app_locale_constant.dart';
import 'package:origa/languages/app_localizations_delegate.dart';
import 'package:origa/models/notification_data_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';
import 'package:origa/utils/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';

import 'authentication/authentication_bloc.dart';
import 'bloc.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;
// local notification integration
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
// late AuthenticationBloc bloc;

Future<void> main() async {
  // bloc = AuthenticationBloc();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Requesting Push Notification Permission
  if (Platform.isIOS) {
    requestNotificationPermission();
  }
  Bloc.observer = EchoBlocDelegate();
  if (kReleaseMode || kDebugMode) {
    // debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) {
        return AuthenticationBloc()..add(AppStarted(context: context));
      },
      child: const MyApp(),
    ),
  );
}

requestNotificationPermission() async {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final NotificationSettings settings = await messaging.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else {
    await openAppSettings();
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('AppLifecycleState--> ${state.name}');
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

  @override
  void initState() {
    super.initState();
    initMobSecurity();
    WidgetsBinding.instance.addObserver(this);

    bloc = BlocProvider.of<AuthenticationBloc>(context);
    // androidAndIOSNotification();
    //
    // final scoresRef =
    //     FirebaseDatabase.instance.ref(Singleton.instance.firebaseDatabaseName);
    // scoresRef.keepSynced(true);
    // Background Notification onclick process
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      debugPrint('Receiving notification messsage ---> $message');

      if (message != null) {
        debugPrint('Receiving notification messsage ---> ${message.data}');
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
      debugPrint('Receiving notification data ---> ${message.data}');
      NotificationDataModel notificationData = NotificationDataModel();
      try {
        notificationData = NotificationDataModel.fromJson(message.data);
        debugPrint('Receiving notification data ---> $notificationData');
      } catch (e) {
        debugPrint(e.toString());
      }
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      final AppleNotification? iOS = message.notification?.apple;
      // debugPrint('Notification print-> ${notification!.title}');
      // debugPrint('notification!.body-> ${notification.body}');
      // listen and Show notification message
      if (Platform.isAndroid) {
        if (notification != null && android != null) {
          debugPrint('Receiving notification data1 ---> $notificationData');
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
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      final RemoteNotification? notification = message.notification;
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

  androidAndIOSNotification() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'origa.ai', // title
      importance: Importance.high,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          bloc!.add(AppStarted(
              context: context,
              notificationData: notificationResponse.payload));
          break;
        case NotificationResponseType.selectedNotificationAction:
          bloc!.add(AppStarted(
              context: context,
              notificationData: notificationResponse.payload));
          break;
      }
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

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

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
      bloc!.add(AppStarted(
          context: context, notificationData: notificationResponse.payload));
    }
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
    }
  }

  Future<dynamic> forgroundOnClickNotification(String? payload) async {
    debugPrint('forgroundOnClickNotification published!... -----> $payload');
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
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: AppThemes().getThemeCollections(),
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
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
          home: addAuthBloc(
            context,
            const SplashScreen(),
          ),
        );
      },
    );
  }

  Future<void> initMobSecurity() async {
    TalsecConfig config = TalsecConfig(
      // For Android
      androidConfig: AndroidConfig(
        expectedPackageName: 'com.mcollect.origa.ai',
        expectedSigningCertificateHashes: ['42xeQ2AAn7kEjb29pG2YTblfOqbWdkEmumnnknVtB0k='],
      ),

      // For iOS
      // iosConfig: IOSconfig(
      //   appBundleId: 'YOUR_APP_BUNDLE_ID',
      //   appTeamId: 'YOUR_APP_TEAM_ID',
      // ),

      // Common email for Alerts and Reports
      watcherMail: 'krishnakant.chouhan@m2pfintech.com',
    );
    TalsecCallback callback = TalsecCallback(
      // For Android
      androidCallback: AndroidCallback(
        onRootDetected: () => print('root'),
        onEmulatorDetected: () => print('emulator'),
        onHookDetected: () => print('hook'),
        onTamperDetected: () => print('tamper'),
        onDeviceBindingDetected: () => print('device binding'),
        onUntrustedInstallationDetected: () => print('untrusted install'),
      ),
      onDebuggerDetected: () => print('debugger'),
    );
    TalsecApp app = TalsecApp(
      config: config,
      callback: callback,
    );
    app.start();
  }

}
