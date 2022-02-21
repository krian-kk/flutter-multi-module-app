import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    Messaging.messaging().delegate = self;
    FirebaseApp.configure()
    application.registerForRemoteNotifications()
    GMSServices.provideAPIKey("AIzaSyCZI9K_T5crucTDPuNMvolMqRBL_srEMOU")
    GeneratedPluginRegistrant.register(with: self)
    Messaging.messaging().isAutoInitEnabled = true;

    if #available(iOS 10.0, *) {
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                  options: authOptions,
                  completionHandler: { _, _ in })
    } else {
    let settings: UIUserNotificationSettings =
    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
    application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    Messaging.messaging().delegate = self
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
