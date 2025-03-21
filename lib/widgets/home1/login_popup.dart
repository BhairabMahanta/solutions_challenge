import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_solution/services/auth_service.dart';
import './components/auth_components.dart'; // Import the file

class LoginPopup {
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();

  static void show(BuildContext context) {
    bool rememberMe = false; // State variable for checkbox

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25), // Match this radius
                  child: Container(
                    width: 450,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(25), // Consistent radius
                      border: Border.all(color: Colors.blue),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          blurRadius: 25,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            AuthComponents.roleButton("Individual",
                                selected: true),
                            AuthComponents.roleButton("Business"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => AuthService.signInWithGoogle(context),
                          child: AuthComponents.socialButton(
                            "Sign up with Google",
                            "images/google.png",
                            () => AuthService.signInWithGoogle(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => AuthService.signInWithGoogle(context),
                          child: AuthComponents.socialButton(
                            "Sign up with Facebook",
                            "images/facebook.png",
                            () => AuthService.signInWithGoogle(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.black54)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("or",
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Expanded(child: Divider(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        AuthComponents.inputField(
                            "Email / Username", emailController),
                        AuthComponents.inputField(
                            "Password", passwordController,
                            obscureText: true),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (val) {
                                    setState(() {
                                      rememberMe = val ?? false;
                                    });
                                  },
                                ),
                                Text("Remember me",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        AuthComponents.authSwitchButtons(context, false,
                            emailController, passwordController),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
