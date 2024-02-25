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
    apiKey: 'AIzaSyDry-J4_MZZyMmfWmP1c9HQrWGxxUvvbSc',
    appId: '1:823047978617:web:0c57f94f226a3c22a69ea8',
    messagingSenderId: '823047978617',
    projectId: 'mobileproject55bnm',
    authDomain: 'mobileproject55bnm.firebaseapp.com',
    storageBucket: 'mobileproject55bnm.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiJE8tpLeFNJimTc5hv0k7_2I6I8pa5nY',
    appId: '1:823047978617:android:7b4648b0bd20c709a69ea8',
    messagingSenderId: '823047978617',
    projectId: 'mobileproject55bnm',
    storageBucket: 'mobileproject55bnm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4nhashHDRjNKEP_UIpyPgOcQLwx7ZP-A',
    appId: '1:823047978617:ios:819a4be2cac2720ea69ea8',
    messagingSenderId: '823047978617',
    projectId: 'mobileproject55bnm',
    storageBucket: 'mobileproject55bnm.appspot.com',
    iosClientId: '823047978617-1vjgq3qa7dav61tlsk97bpiat2uffq41.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileprojectbeyzanur',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4nhashHDRjNKEP_UIpyPgOcQLwx7ZP-A',
    appId: '1:823047978617:ios:5739e051190db9afa69ea8',
    messagingSenderId: '823047978617',
    projectId: 'mobileproject55bnm',
    storageBucket: 'mobileproject55bnm.appspot.com',
    iosClientId: '823047978617-pg9lhfvppi3c9meh2jklma0pdl87uof7.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileprojectbeyzanur.RunnerTests',
  );
}