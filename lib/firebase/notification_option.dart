import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    // case TargetPlatform.windows:
    //   throw UnsupportedError(
    //     'DefaultFirebaseOptions have not been configured for windows - '
    //         'you can reconfigure this by running the FlutterFire CLI again.',
    //   );
    // case TargetPlatform.linux:
    //   throw UnsupportedError(
    //     'DefaultFirebaseOptions have not been configured for linux - '
    //         'you can reconfigure this by running the FlutterFire CLI again.',
    //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyD_XCGnc8X-rKoPyLc7FWvKuCoxmaBpTc0",
      appId: "1:577289903795:android:839e32185f5af0088d9ac6",
      messagingSenderId: "577289903795",
      projectId: "flutter-loop",
      storageBucket: "flutter-loop.appspot.com");
}
