// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDANxXBzlVqorsS1mAeGwIrLe30sLGzwOw',
    appId: '1:891235023265:web:bbbbbcebd6f7a14fc273e0',
    messagingSenderId: '891235023265',
    projectId: 'test--maps-a6301',
    authDomain: 'test--maps-a6301.firebaseapp.com',
    storageBucket: 'test--maps-a6301.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCz40Lq7IFmQ-TqNEpwydHU8ctvfvZMCrc',
    appId: '1:891235023265:android:546dd8118e413261c273e0',
    messagingSenderId: '891235023265',
    projectId: 'test--maps-a6301',
    storageBucket: 'test--maps-a6301.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3QZ--TPYW11c7AptDBD33vAJqzxthDhI',
    appId: '1:891235023265:ios:3464eb13e05938cec273e0',
    messagingSenderId: '891235023265',
    projectId: 'test--maps-a6301',
    storageBucket: 'test--maps-a6301.appspot.com',
    iosClientId: '891235023265-h3ijlrkbta51k7r86vnsjdidckg7cq3l.apps.googleusercontent.com',
    iosBundleId: 'com.osamahabib.taskGoogleMaps',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3QZ--TPYW11c7AptDBD33vAJqzxthDhI',
    appId: '1:891235023265:ios:3464eb13e05938cec273e0',
    messagingSenderId: '891235023265',
    projectId: 'test--maps-a6301',
    storageBucket: 'test--maps-a6301.appspot.com',
    iosClientId: '891235023265-h3ijlrkbta51k7r86vnsjdidckg7cq3l.apps.googleusercontent.com',
    iosBundleId: 'com.osamahabib.taskGoogleMaps',
  );
}
