import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MissionsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to Missions Screen
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[900], // Deep purple background
        shadowColor: Colors.redAccent, // Red glow effect
        elevation: 8,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        "JOIN NEW MISSIONS !",
        style: GoogleFonts.micro5(
          fontSize: 31,
          color: Colors.red,
          shadows: [
            Shadow(
              blurRadius: 3,
              color: Colors.redAccent,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }
}
