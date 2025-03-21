import 'package:firebase_dart/auth.dart';

class SignupService {
  static Future<String?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user
          ?.sendEmailVerification(); // Send verification email
      return null; // Success, no error message
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  static Future<String?> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }
}
