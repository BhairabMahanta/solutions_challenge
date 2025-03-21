import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> signUp(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the email is already registered
    if (prefs.containsKey(email)) {
      return false; // Email already exists
    }

    // Save email and password
    await prefs.setString(email, password);
    return true; // Signup successful
  }

  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if email exists and password matches
    if (prefs.containsKey(email) && prefs.getString(email) == password) {
      return true; // Login successful
    }

    return false; // Login failed
  }
}
