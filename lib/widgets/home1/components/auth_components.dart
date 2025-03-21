import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/material.dart';
import 'package:new_solution/widgets/home1/login_popup.dart';
import 'package:new_solution/widgets/home1/signup_popup.dart';
import '../../../services/auth_service.dart';

class AuthComponents {
  // Role button
  static Widget roleButton(String title, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.blueAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black54),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.black : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Social sign-up/login button
  static Widget socialButton(
      String text, String assetPath, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white70),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 20),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Input field
  static Widget inputField(String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black87),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  // Authentication switch buttons (Register & Login)
  static Widget authSwitchButtons(
    BuildContext context,
    bool isLoginPage,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.blue),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async => _handleAuthAction(
                  context, emailController, passwordController, true),
              child: switchButton("Log In", isLoginPage),
            ),
            GestureDetector(
              onTap: () async => _handleAuthAction(
                  context, emailController, passwordController, false),
              child: switchButton("Register", !isLoginPage),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _handleAuthAction(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      bool isLogin) async {
    if (isLogin) {
      await _authenticateUser(
          context, emailController, passwordController, true);
    } else {
      Navigator.pop(context);
      SignupPopup.show(context);
    }
  }

  static Future<void> _authenticateUser(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      bool isLogin) async {
    String input = emailController.text.trim();
    String password = passwordController.text.trim();

    if (input.isEmpty || password.isEmpty) {
      AuthService.showError(
          context, "Missing Details", "Please enter both email and password.");
      return;
    }

    String email =
        input.contains("@") ? input : await _getEmailFromUsername(input);

    if (email.isEmpty) {
      AuthService.showError(context, "Invalid Username", "Username not found.");
      return;
    }

    // 🚨 Remove this: Closing the popup before checking login status
    // if (Navigator.of(context).canPop()) {
    //   Navigator.pop(context);
    // }

    UserCredential? userCredential = isLogin
        ? await AuthService.signInWithEmailPassword(context, email, password)
        : await AuthService.registerWithEmailPassword(
            context, "akai", email, password);

    if (userCredential == null) {
      print("null");
    } else if (!(userCredential.user?.emailVerified ?? false)) {
      print("⚠️ Email not verified. Please verify your email.");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Login failed"),
            content: Text("Please verify your email first."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      });
    } else {
      print("🎉 Success! User: ${userCredential.user?.email}");
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.pop(context);
      }
    }
  }

  static Future<String> _getEmailFromUsername(String username) async {
    try {
      var dbRef = FirebaseDatabase(
        app: Firebase.app(),
        databaseURL:
            "https://climatesolution-48ea6-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).reference().child("users");

      var snapshot =
          await dbRef.orderByChild("username").equalTo(username).once();

      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic> users = snapshot.value as Map<dynamic, dynamic>;
        var user = users.values.first;
        return user["email"] ?? "";
      }
    } catch (e) {
      print("❌ Error fetching email for username: $e");
    }
    return "";
  }

  static Widget switchButton(String text, bool isSelected) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white, // Keep background white
              borderRadius: BorderRadius.circular(
                  22), // Make sure both buttons are rounded
              border: !isSelected
                  ? Border.all(
                      color: Colors.blue,
                      width: 1.8) // Selected button gets border
                  : null, // Unselected blends with outer container
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
