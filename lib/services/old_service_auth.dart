// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';

// class AuthService {
//   final _supabase = Supabase.instance.client.auth;

//   Future<bool> signUp(String email, String password) async {
//     try {
//       final response = await _supabase.signUp(email: email, password: password);

//       if (response.user != null) {
//         print("✅ Signup successful. Verification email sent.");
//         return true;
//       } else {
//         print("❌ Signup failed.");
//         return false;
//       }
//     } on AuthException catch (e) {
//       print("🚨 Signup Error: ${e.message}");
//       return false;
//     }
//   }

//   Future<bool> signIn(String email, String password) async {
//     try {
//       final response =
//           await _supabase.signInWithPassword(email: email, password: password);

//       if (response.user != null) {
//         print("✅ Login successful.");
//         return true;
//       } else {
//         print("❌ Login failed.");
//         return false;
//       }
//     } on AuthException catch (e) {
//       print("🚨 Login Error: ${e.message}");
//       return false;
//     }
//   }

//   Future<void> signOut() async {
//     await _supabase.signOut();
//     print("✅ User signed out.");
//   }

//   Future<bool> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser == null) {
//         print("❌ Google Sign-In cancelled.");
//         return false;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final response = await Supabase.instance.client.auth.signInWithIdToken(
//         provider: OAuthProvider.google, // ✅ Correct way
//         idToken: googleAuth.idToken!,
//       );

//       if (response.user != null) {
//         print("✅ Google Sign-In successful.");
//         return true;
//       } else {
//         print("❌ Google Sign-In failed.");
//         return false;
//       }
//     } on AuthException catch (e) {
//       print("🚨 Google Sign-In Error: ${e.message}");
//       return false;
//     }
//   }
// }
