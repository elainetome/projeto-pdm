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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBhY82DIr8PMRQJ-Sej2UI62u7rXtLPs8s',
    appId: '1:78888195796:web:d9b1f6e9356b4ad03ecd41',
    messagingSenderId: '78888195796',
    projectId: 'app-papelaria',
    authDomain: 'app-papelaria.firebaseapp.com',
    storageBucket: 'app-papelaria.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzR5f5rHrxcEX0h3lChGh2FF7qXdBA5DU',
    appId: '1:78888195796:android:6348b7605c0936f73ecd41',
    messagingSenderId: '78888195796',
    projectId: 'app-papelaria',
    storageBucket: 'app-papelaria.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBu8b5xH2eMVMMZiwPfJSaf4taAn4ZAI9Q',
    appId: '1:78888195796:ios:8a2284e4612f4d8d3ecd41',
    messagingSenderId: '78888195796',
    projectId: 'app-papelaria',
    storageBucket: 'app-papelaria.appspot.com',
    iosClientId: '78888195796-oms5f4gnht77t60in2omurmm49kj95h2.apps.googleusercontent.com',
    iosBundleId: 'com.example.app04Imc',
  );
}