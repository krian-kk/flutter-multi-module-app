// // File generated by FlutterFire CLI.
// // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;
//
// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options_uat.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//         'you can reconfigure this by running the FlutterFire CLI again.',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }
//
//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyAILjLc9SRaolhytYHsy46Q418E4igeER0',
//     appId: '1:927842067224:android:7016623f8b54349138746d',
//     messagingSenderId: '927842067224',
//     projectId: 'instalmint-prod',
//     databaseURL: 'https://instalmint-prod-default-rtdb.firebaseio.com',
//     storageBucket: 'instalmint-prod.appspot.com',
//   );
//
//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyDZSVdBFQckiLyUQU4jCOdXHifXSZ_h7jQ',
//     appId: '1:927842067224:ios:9a5d8e753b98f73538746d',
//     messagingSenderId: '927842067224',
//     projectId: 'instalmint-prod',
//     databaseURL: 'https://instalmint-prod-default-rtdb.firebaseio.com',
//     storageBucket: 'instalmint-prod.appspot.com',
//     iosClientId:
//         '927842067224-gvh1p4k8d1g2u9uqvri25hqjkmeacfef.apps.googleusercontent.com',
//     iosBundleId: 'com.mcollect.origa.ai',
//   );
// }
