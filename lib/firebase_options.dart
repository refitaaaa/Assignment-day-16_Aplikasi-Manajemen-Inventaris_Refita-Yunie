// Firebase configuration for Inventory Management
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuCugYp41ke1ezEyWX6iKSfTHDaTZ3yG8',
    appId: '1:800851578572:android:8e749dca9fc9c86925bc69',
    messagingSenderId: '800851578572',
    projectId: 'inventory-management-641fb',
    storageBucket: 'inventory-management-641fb.firebasestorage.app',
  );
}