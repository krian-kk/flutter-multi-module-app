import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    Messaging.messaging().delegate = self;
    FirebaseApp.configure()
    application.registerForRemoteNotifications()
    GMSServices.provideAPIKey("AIzaSyCZI9K_T5crucTDPuNMvolMqRBL_srEMOU")
    GeneratedPluginRegistrant.register(with: self)
    Messaging.messaging().isAutoInitEnabled = true;
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
