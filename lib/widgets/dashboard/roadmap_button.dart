import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoadmapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to Roadmap Screen
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[900], // Dark background
        shadowColor: Colors.green, // Green glow effect
        elevation: 8, // Raised effect
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        "ROADMAPS / STAGES",
        style: GoogleFonts.micro5(
          textStyle: TextStyle(
            fontSize: 31,
            color: Colors.green,
            shadows: [
              Shadow(
                blurRadius: 3,
                color: Colors.greenAccent,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
