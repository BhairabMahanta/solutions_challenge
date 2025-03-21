import 'package:cloud_firestore/cloud_firestore.dart' hide FirebaseFirestore;
import 'package:firebase_dart/database.dart';
import 'package:firebase_dart/firebase_dart.dart' as firebase_dart;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final firebase_dart.FirebaseApp app = firebase_dart.Firebase.app();
  static final firebase_dart.FirebaseAuth auth =
      firebase_dart.FirebaseAuth.instanceFor(app: app);

  static void showError(BuildContext context, String title, String message) {
    if (!context.mounted) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }

  static void showSnackbar(BuildContext context, String message, Color color) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// **Register User with Email & Password**
  static Future<firebase_dart.UserCredential?> registerWithEmailPassword(
      BuildContext context,
      String username,
      String email,
      String password) async {
    try {
      firebase_dart.UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebase_dart.User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        print("✅ Registration successful: ${user.email}");

        try {
          // Use FirebaseDart Firestore instead of cloud_firestore
          var db = firebase_dart.FirebaseDatabase(app: app);

// Writing Data
          await db.reference().child("users").child(user.uid).set({
            "uid": user.uid,
            "username": username,
            "email": email,
            "avatar": "images/avatar1.jpg",
            "level": 1,
            "xp": 0,
            "climate_score": 0,
            "daily_actions": 0,
            "climate_quests": 0,
          });

// Reading Data
          DatabaseReference ref = db.reference().child("users").child(user.uid);
          DataSnapshot snapshot = await ref.get();
          print("User Data: ${snapshot.value}");

          print("✅ Firestore data added for ${user.email}");
        } catch (e) {
          print("❌ Firestore write error: $e");
          showError(context, "Database Error", e.toString());
        }

        showSnackbar(
            context, "Verification email sent. Please verify.", Colors.green);
      }
      return userCredential;
    } catch (e) {
      print("❌ Registration error: $e");
      showError(context, "Registration failed", e.toString());
      return null;
    }
  }

  /// **Sign In with Email & Password**
  static Future<firebase_dart.UserCredential?> signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      firebase_dart.UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      print("🔹 user: $userCredential"); // Add this
      if (!(userCredential.user?.emailVerified ?? false)) {
        print("⚠️ Email not verified.");

        showSnackbar(context,
            "⚠️ Email not verified. Please verify your email.", Colors.orange);
        return userCredential;
      }

      print("✅ Login successful: ${userCredential.user?.email}");
      showSnackbar(context, "✅ Login successful.", Colors.green);
      return userCredential;
    } catch (e) {
      print("❌ Login error: $e");
      showError(context, "Login failed", e.toString());
      return null;
    }
  }

  /// **Google Sign-Up & Login (Auto Register)**
  static Future<firebase_dart.UserCredential?> signInWithGoogle(
      BuildContext context) async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ Google Sign-In cancelled.");
        showSnackbar(context, "Google Sign-In cancelled.", Colors.red);
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final firebase_dart.OAuthCredential credential =
          firebase_dart.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      firebase_dart.UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print("✅ Google Sign-In successful: ${userCredential.user?.email}");

      // Store user in Firestore if it's a new user
      final userRef = firebase_dart.FirebaseDatabase(app: app)
          .reference()
          .child("users")
          .child(userCredential.user?.uid ?? "");

      final userDoc = await userRef.get();
      if (!userDoc.exists) {
        await userRef.set({
          "uid": userCredential.user?.uid,
          "username": googleUser.displayName ?? "New User",
          "email": googleUser.email,
          "avatar": googleUser.photoUrl ?? "images/default-avatar.jpg",
          "level": 1,
          "xp": 0,
          "climate_score": 0,
          "daily_actions": 0,
          "climate_quests": 0,
          // "created_at": cloud_firestore.Timestamp.now(),
        });
        print("✅ Firestore data added for ${googleUser.email}");
      }

      return userCredential;
    } catch (e) {
      print("❌ Google Sign-In error: $e");
      showError(context, "Google sign-in failed", e.toString());
      return null;
    }
  }

  /// **Sign Out**
  static Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    print("✅ User signed out.");
    showSnackbar(context, "Signed out successfully!", Colors.green);
  }
}
