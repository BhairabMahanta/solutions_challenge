import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthForm extends StatefulWidget {
  final String action;
  final VoidCallback onSwitch;

  const AuthForm({Key? key, required this.action, required this.onSwitch})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  bool _obscurePassword = true;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      bool success;
      if (widget.action == "Signup") {
        success = await _authService.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        print("Signup Success: $success");
        if (!success) throw "Email already exists";
      } else {
        success = await _authService.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        print("Login Success: $success");
        if (!success) throw "Invalid credentials";
      }

      Navigator.of(context).pop(); // Close dialog on success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Authentication failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.action == "Login" ? "Welcome Back!" : "Create Account",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(Icons.email, "Email", _emailController, false),
              const SizedBox(height: 10),
              _buildPasswordField(),
              if (widget.action == "Signup") ...[
                const SizedBox(height: 10),
                _buildTextField(Icons.lock, "Confirm Password",
                    _confirmPasswordController, true),
              ],
              const SizedBox(height: 12),
              _buildActionButton(),
              _buildSwitchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint,
      TextEditingController controller, bool obscure) {
    return SizedBox(
      width: 280,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "$hint cannot be empty";
          if (hint == "Confirm Password" && value != _passwordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: 280,
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
          labelText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: IconButton(
            icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Password cannot be empty" : null,
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.blue,
        ),
        child: Text(widget.action, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSwitchButton() {
    return TextButton(
      onPressed: widget.onSwitch,
      child: Text(
        widget.action == "Login"
            ? "Don't have an account? Signup"
            : "Already have an account? Login",
        style: const TextStyle(fontSize: 13, color: Colors.blue),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
