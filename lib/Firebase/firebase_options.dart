import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCytR3mI6n7vh9_5yyyEdai6uUwFhevcEU",
    authDomain: "e-parking-challan-77e13.firebaseapp.com",
    databaseURL: "https://e-parking-challan-77e13-default-rtdb.firebaseio.com",
    projectId: "e-parking-challan-77e13",
    storageBucket: "e-parking-challan-77e13.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abcdef",
    measurementId: "G-XXXXXX",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCytR3mI6n7vh9_5yyyEdai6uUwFhevcEU",
    appId: "1:123456789:android:abcdef",
    messagingSenderId: "123456789",
    projectId: "e-parking-challan-77e13",
    storageBucket: "e-parking-challan-77e13.appspot.com",
    databaseURL: "https://e-parking-challan-77e13-default-rtdb.firebaseio.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCytR3mI6n7vh9_5yyyEdai6uUwFhevcEU",
    appId: "1:123456789:ios:abcdef",
    messagingSenderId: "123456789",
    projectId: "e-parking-challan-77e13",
    storageBucket: "e-parking-challan-77e13.appspot.com",
    iosBundleId: "com.example.yourapp",
    databaseURL: "https://e-parking-challan-77e13-default-rtdb.firebaseio.com",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyCytR3mI6n7vh9_5yyyEdai6uUwFhevcEU",
    appId: "1:123456789:macos:abcdef",
    messagingSenderId: "123456789",
    projectId: "e-parking-challan-77e13",
    storageBucket: "e-parking-challan-77e13.appspot.com",
    iosBundleId: "com.example.yourapp",
    databaseURL: "https://e-parking-challan-77e13-default-rtdb.firebaseio.com",
  );
}
