import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to Leaderboard Screen
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Orange background
        shadowColor: Colors.black, // Black shadow effect
        elevation: 8,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        "LEADERBOARD",
        style: GoogleFonts.micro5(
          fontSize: 31,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 3,
              color: Colors.black54,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }
}
