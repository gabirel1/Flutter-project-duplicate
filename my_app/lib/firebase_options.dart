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
    apiKey: 'AIzaSyDSZRueSZByiXxPBO-s07NeSsDU0RRsaIM',
    appId: '1:495774674643:web:d9457089f01ad8edcaee26',
    messagingSenderId: '495774674643',
    projectId: 'flutter-epitech-93ace',
    authDomain: 'flutter-epitech-93ace.firebaseapp.com',
    databaseURL: 'https://flutter-epitech-93ace-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-epitech-93ace.appspot.com',
    measurementId: 'G-XSTNVVR0HZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQ11wRhIKPVHoOhNeMyTP-3W94L7klOP8',
    appId: '1:495774674643:android:0a9062b735d9fea9caee26',
    messagingSenderId: '495774674643',
    projectId: 'flutter-epitech-93ace',
    databaseURL: 'https://flutter-epitech-93ace-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-epitech-93ace.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbZtp34t6Mt_itbtRKTJeulDqwJ3-m1uk',
    appId: '1:495774674643:ios:7a03462ea0323024caee26',
    messagingSenderId: '495774674643',
    projectId: 'flutter-epitech-93ace',
    databaseURL: 'https://flutter-epitech-93ace-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-epitech-93ace.appspot.com',
    iosClientId: '495774674643-o54oh2p0eqdf4q8l0sf6rsglppl87u88.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbZtp34t6Mt_itbtRKTJeulDqwJ3-m1uk',
    appId: '1:495774674643:ios:fae58a4f8dd0d4b9caee26',
    messagingSenderId: '495774674643',
    projectId: 'flutter-epitech-93ace',
    databaseURL: 'https://flutter-epitech-93ace-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-epitech-93ace.appspot.com',
    iosClientId: '495774674643-eg20o6brm7k500gbhhqrr7660kqgeiii.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp.RunnerTests',
  );
}
