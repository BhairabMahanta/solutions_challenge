import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_solution/widgets/home1/login_popup.dart';
import 'package:new_solution/services/auth_service.dart'; // Import your auth service

class SignupPopup {
  static void show(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    bool isChecked = false;
    String selectedRole = "Individual";

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 450,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Role Selection
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _roleButton("Individual", selectedRole, (role) {
                          setState(() => selectedRole = role);
                        }),
                        _roleButton("Business", selectedRole, (role) {
                          setState(() => selectedRole = role);
                        }),
                        _roleButton("Government", selectedRole, (role) {
                          setState(() => selectedRole = role);
                        }),
                        _roleButton("Researcher", selectedRole, (role) {
                          setState(() => selectedRole = role);
                        }),
                        _roleButton("NGO", selectedRole, (role) {
                          setState(() => selectedRole = role);
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Social Sign-Up Buttons
                    _socialButton(
                      "Sign up with Google",
                      "images/google.png",
                      () => AuthService.signInWithGoogle(context),
                    ),
                    const SizedBox(height: 10),
                    _socialButton(
                      "Sign up with Apple",
                      "images/facebook.png",
                      () => AuthService.signInWithGoogle(context),
                    ),
                    const SizedBox(height: 10),

                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.black54)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child:
                              Text("or", style: TextStyle(color: Colors.black)),
                        ),
                        Expanded(child: Divider(color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Input Fields
                    _inputField("Email", emailController),
                    _inputField("Username", usernameController),
                    _inputField("Password", passwordController,
                        obscureText: true),
                    _inputField("Confirm Password", confirmPasswordController,
                        obscureText: true),
                    const SizedBox(height: 10),

                    // Agree to Terms
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (val) {
                            setState(() {
                              isChecked = val ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            "I agree to the Terms & Conditions",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Register Button
                    ElevatedButton(
                      onPressed: () async {
                        if (!isChecked) {
                          AuthService.showError(context, "Error",
                              "You must agree to the Terms & Conditions.");
                          return;
                        }
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          AuthService.showError(
                              context, "Error", "Passwords do not match.");
                          return;
                        }

                        await AuthService.registerWithEmailPassword(
                          context,
                          usernameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                      child: Text("Register"),
                    ),

                    const SizedBox(height: 10),

                    // Switch to Log In
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        LoginPopup.show(context);
                      },
                      child: Text("Already have an account? Log In"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Role button
  static Widget _roleButton(
      String title, String selectedRole, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: title == selectedRole ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black54),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: title == selectedRole ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Social sign-up button
  static Widget _socialButton(
      String text, String assetPath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
            Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Input field
  static Widget _inputField(String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black87),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
