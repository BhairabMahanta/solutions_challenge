import 'package:flutter/material.dart';
import 'package:firebase_dart/firebase_dart.dart' as firebase;
import 'package:new_solution/widgets/auth_buttons.dart';
import 'package:new_solution/widgets/chatbot_overlay.dart';
import 'package:new_solution/widgets/home1/login_popup.dart';
import 'package:new_solution/widgets/home1/signup_popup.dart';
import 'user_profile_menu.dart';

Widget buildNavLinks(BuildContext context) {
  return StreamBuilder<firebase.User?>(
    stream: firebase.FirebaseAuth.instance.authStateChanges(),
    builder: (context, AsyncSnapshot<firebase.User?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // 🔄 Show loading while fetching auth state
      }

      if (snapshot.hasError) {
        return Text("Error loading user data"); // ❌ Handle auth errors safely
      }

      final user = snapshot.data;
      final bool isVerified = user?.emailVerified ?? false;

      return Row(
        children: [
          navItem("Home", () {}),
          navItem("Solutions", () {}),
          navItem("Impact", () {}),
          navItem("About Us", () {}),
          navItem("Roadmap", () {}),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {
              ChatbotPopup.show(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green[400],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text("Sherpa AI"),
          ),
          SizedBox(width: 20),
          (user != null && isVerified)
              ? UserProfileMenu(user: user)
              : _authButtons(context),
        ],
      );
    },
  );
}

/// ✅ Firebase should be initialized in `main.dart` BEFORE running the app
Future<void> initializeFirebase() async {
  if (firebase.Firebase.apps.isEmpty) {
    await firebase.Firebase.initializeApp(
      options: firebase.FirebaseOptions(
        apiKey: "AIzaSyDB1eFVR_48DHgIBkkkgaO6GprIeE3V5ns",
        authDomain: "climatesolution-48ea6.firebaseapp.com",
        projectId: "climatesolution-48ea6",
        storageBucket: "climatesolution-48ea6.appspot.com",
        messagingSenderId: "24961272906",
        appId: "1:24961272906:web:8ea9698155acbceecf2ab3",
        databaseURL:
            "https://climatesolution-48ea6-default-rtdb.firebaseio.com",
      ),
    );
  }
}

Widget navItem(String title, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
      child: Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
    ),
  );
}

Widget _authButtons(BuildContext context) {
  return Row(
    children: [
      OutlinedButton(
        onPressed: () {
          LoginPopup.show(context);
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        ),
        child: Text("Sign In", style: TextStyle(color: Colors.black)),
      ),
      SizedBox(width: 8),
      ElevatedButton(
        onPressed: () {
          SignupPopup.show(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        ),
        child: Text("Get Started", style: TextStyle(color: Colors.white)),
      ),
    ],
  );
}
