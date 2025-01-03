// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBXOaMsIwz7klToZTAy1woq1Tv0c864vpA',
    appId: '1:567556118089:web:7a638d9cebffbedf645198',
    messagingSenderId: '567556118089',
    projectId: 'haych-browser',
    authDomain: 'haych-browser.firebaseapp.com',
    storageBucket: 'haych-browser.firebasestorage.app',
    measurementId: 'G-RLHZE0DRX3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbmso6_udVRY3ymp6rMdZH5tA9VVGhfs0',
    appId: '1:567556118089:android:f5ea252989e52db0645198',
    messagingSenderId: '567556118089',
    projectId: 'haych-browser',
    storageBucket: 'haych-browser.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACIEzqsWPqGkX_vewrcx7WGOQhl2IJLIQ',
    appId: '1:567556118089:ios:9c01268802443aed645198',
    messagingSenderId: '567556118089',
    projectId: 'haych-browser',
    storageBucket: 'haych-browser.firebasestorage.app',
    iosClientId: '567556118089-0vjbbkv624t6m2829fn6q8giglpnq53m.apps.googleusercontent.com',
    iosBundleId: 'haych.app.browser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACIEzqsWPqGkX_vewrcx7WGOQhl2IJLIQ',
    appId: '1:567556118089:ios:d57efa8a32dc2859645198',
    messagingSenderId: '567556118089',
    projectId: 'haych-browser',
    storageBucket: 'haych-browser.firebasestorage.app',
    iosClientId: '567556118089-4vl9d4doe0rb4lr7t1qo9fsprjk6n5nc.apps.googleusercontent.com',
    iosBundleId: 'com.example.adaptorGames',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXOaMsIwz7klToZTAy1woq1Tv0c864vpA',
    appId: '1:567556118089:web:31628b3f1c31ffe9645198',
    messagingSenderId: '567556118089',
    projectId: 'haych-browser',
    authDomain: 'haych-browser.firebaseapp.com',
    storageBucket: 'haych-browser.firebasestorage.app',
    measurementId: 'G-XT85J1B2G5',
  );
}
