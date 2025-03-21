import 'package:firebase_dart/firebase_dart.dart';

class FirebaseService {
  static late FirebaseAuth auth;

  static Future<void> initializeFirebase() async {
    FirebaseDart.setup();

    var options = FirebaseOptions(
        apiKey: "AIzaSyDB1eFVR_48DHgIBkkkgaO6GprIeE3V5ns",
        authDomain: "climatesolution-48ea6.firebaseapp.com",
        projectId: "climatesolution-48ea6",
        storageBucket: "climatesolution-48ea6.firebasestorage.app",
        messagingSenderId: "24961272906",
        appId: "1:24961272906:web:8ea9698155acbceecf2ab3",
        measurementId: "G-9HCYDWF31V");

    // Initialize Firebase
    var app = await Firebase.initializeApp(options: options);
    auth = FirebaseAuth.instanceFor(app: app);

    print("✅ Firebase initialized successfully!");
  }
}
