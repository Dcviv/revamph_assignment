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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDITHrwUN0HpVg23_Ft1MASJ3tuYcNkJWo',
    appId: '1:848940562038:web:0facf950ccca1c10f05157',
    messagingSenderId: '848940562038',
    projectId: 'revamph-assignment-3e43a',
    authDomain: 'revamph-assignment-3e43a.firebaseapp.com',
    storageBucket: 'revamph-assignment-3e43a.appspot.com',
    measurementId: 'G-XTSS31QQY9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-a616eWDR2t3YLTspMhpj8LhsGHPhkJs',
    appId: '1:848940562038:android:c062fa5f100d6822f05157',
    messagingSenderId: '848940562038',
    projectId: 'revamph-assignment-3e43a',
    storageBucket: 'revamph-assignment-3e43a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUGCQ9jvAzueKw-DXY42-lGz_OA9WzaSQ',
    appId: '1:848940562038:ios:a4ec789a4f22f08af05157',
    messagingSenderId: '848940562038',
    projectId: 'revamph-assignment-3e43a',
    storageBucket: 'revamph-assignment-3e43a.appspot.com',
    iosClientId: '848940562038-96kbeo0iii9qutupabmj3gm0u8favc80.apps.googleusercontent.com',
    iosBundleId: 'com.example.revamphAssignment',
  );
}