import 'package:flutter/material.dart';

class GreenStrideAuthScreen extends StatefulWidget {
  @override
  _GreenStrideAuthScreenState createState() => _GreenStrideAuthScreenState();
}

class _GreenStrideAuthScreenState extends State<GreenStrideAuthScreen> {
  bool isLogin = true; // Toggle between login & signup

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: isLogin ? _buildLoginForm() : _buildSignupForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      key: ValueKey(1),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Welcome Back!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _buildTextField(Icons.email, "Email", false),
        SizedBox(height: 10),
        _buildTextField(Icons.lock, "Password", true),
        SizedBox(height: 10),
        _buildRememberForgotRow(),
        SizedBox(height: 15),
        _buildButton("Sign In"),
        SizedBox(height: 10),
        _buildSocialButtons(),
        SizedBox(height: 10),
        TextButton(
            onPressed: toggleAuthMode,
            child: Text("Don't have an account? Sign Up"))
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      key: ValueKey(2),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Create Account",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _buildTextField(Icons.person, "Full Name", false),
        SizedBox(height: 10),
        _buildTextField(Icons.email, "Email", false),
        SizedBox(height: 10),
        _buildTextField(Icons.lock, "Password", true),
        SizedBox(height: 10),
        _buildTextField(Icons.lock, "Confirm Password", true),
        SizedBox(height: 10),
        _buildCheckbox(),
        SizedBox(height: 15),
        _buildButton("Create Account"),
        SizedBox(height: 10),
        _buildSocialButtons(),
        SizedBox(height: 10),
        TextButton(
            onPressed: toggleAuthMode,
            child: Text("Already have an account? Sign In"))
      ],
    );
  }

  Widget _buildTextField(IconData icon, String hint, bool obscure) {
    return TextFormField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildRememberForgotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: false, onChanged: (val) {}),
            Text("Remember Me"),
          ],
        ),
        TextButton(onPressed: () {}, child: Text("Forgot Password?"))
      ],
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (val) {}),
        Expanded(
            child: Text("I agree to the Terms of Service and Privacy Policy"))
      ],
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.green.shade700,
        ),
        child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        Text("OR CONTINUE WITH"),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _socialButton("Google", Colors.red, Icons.g_translate),
            _socialButton("Facebook", Colors.blue, Icons.facebook),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(String text, Color color, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
