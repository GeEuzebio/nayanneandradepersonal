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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRJl3J1mVLHbNhmCPEET_Wnxo8bqq1yiQ',
    appId: '1:169381549720:android:dfbe4b96ff2099b548a2ed',
    messagingSenderId: '169381549720',
    projectId: 'naypersonal',
    databaseURL: 'https://naypersonal-default-rtdb.firebaseio.com',
    storageBucket: 'naypersonal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlMadBjL1iugQIJyG0TXtn1Rh0T0rBFU0',
    appId: '1:169381549720:ios:df55c5270cead4bb48a2ed',
    messagingSenderId: '169381549720',
    projectId: 'naypersonal',
    databaseURL: 'https://naypersonal-default-rtdb.firebaseio.com',
    storageBucket: 'naypersonal.appspot.com',
    iosClientId: '169381549720-110aj4c075roilkjco5drslrk1dqsv4a.apps.googleusercontent.com',
    iosBundleId: 'com.owl.sys.nayanneandradepersonal.nayanneandradepersonal',
  );
}
