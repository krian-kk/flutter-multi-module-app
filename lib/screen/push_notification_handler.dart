import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

class PushNotificationHandlers {
  static BuildContext? context;
  static final activationEvents = ably.Push.activationEvents;
  static final notificationEvents = ably.Push.notificationEvents;
  // static late final FlutterLocalNotificationsPlugin
  //     flutterLocalNotificationsPlugin;

  static final BehaviorSubject<List<ably.RemoteMessage>>
      _receivedMessagesBehaviorSubject =
      BehaviorSubject<List<ably.RemoteMessage>>.seeded([]);
  static ValueStream<List<ably.RemoteMessage>> receivedMessagesStream =
      _receivedMessagesBehaviorSubject.stream;

  static void setUpEventHandlers() {
    activationEvents.onUpdateFailed.listen((error) async {
      logAndDisplayError(error,
          prefixMessage: 'Push update registration failed');
    });
    activationEvents.onActivate.listen((error) async {
      logAndDisplayError(error, prefixMessage: 'Push activation failed');
    });
    activationEvents.onDeactivate.listen((error) async {
      logAndDisplayError(error, prefixMessage: 'Push deactivation failed');
    });
  }

  static void setUpMessageHandlers() {
    setUpAndroidNotificationChannels();
    getLaunchMessage();

    notificationEvents.setOnBackgroundMessage(_backgroundMessageHandler);

    notificationEvents.setOnOpenSettings(() {
      debugPrint(
          'The iOS user has asked to see the In-app Notification Settings');
    });

    notificationEvents.onMessage.listen((message) {
      addMessage(message);

      ably.Notification? notification = message.notification;

      if (notification != null && notification.body!.isNotEmpty) {
        debugPrint('--------notification data---------');
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, const NotificationDetails());
      }

      debugPrint('RemoteMessage received while app is in foreground:\n'
          'RemoteMessage.Notification: ${message.notification!.title}'
          'RemoteMessage.Data: ${message.notification!.body}');
    });

    notificationEvents.setOnShowNotificationInForeground((message) async {
      debugPrint(
          'Opting to show the notification when the app is in the foreground.');
      return true;
    });

    notificationEvents.onNotificationTap.listen((remoteMessage) {
      addMessage(remoteMessage);
      debugPrint('Notification was tapped: $remoteMessage');
    });
  }

  static void setUpAndroidNotificationChannels() async {
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'origa.ai', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void selectNotification(String? payload) async {
    //Handle notification tapped logic here
    debugPrint('flutter Local Notifications Plugin payload ---> $payload');
  }

  /// You can get the notification which launched the app by a user tapping it.
  static void getLaunchMessage() {
    notificationEvents.notificationTapLaunchedAppFromTerminated
        .then((remoteMessage) {
      if (remoteMessage != null) {
        addMessage(remoteMessage);
        debugPrint(
            'The app was launched by the user by tapping the notification ${remoteMessage.data}');
      }
    });
  }

  static void clearReceivedMessages() {
    _receivedMessagesBehaviorSubject.add([]);
  }

  static Future<void> _backgroundMessageHandler(
      ably.RemoteMessage message) async {
    addMessage(message);
    debugPrint('RemoteMessage received while app is in background:\n'
        'RemoteMessage.Notification: ${message.notification}'
        'RemoteMessage.Data: ${message.data}');
  }

  static void addMessage(ably.RemoteMessage message) {
    final newList = List<ably.RemoteMessage>.from(receivedMessagesStream.value)
      ..add(message);
    _receivedMessagesBehaviorSubject.add(newList);
  }
}

void logAndDisplayError(ably.ErrorInfo? errorInfo,
    {String prefixMessage = ' '}) {
  if (errorInfo == null) {
    return;
  }
  debugPrint(errorInfo.message);
  Fluttertoast.showToast(
      msg: 'Error: $prefixMessage. '
          '${errorInfo.message ?? 'No error message provided'}',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16);
}
