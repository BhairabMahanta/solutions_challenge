import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarSection extends StatefulWidget {
  @override
  _AvatarSectionState createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  final List<String> avatarImages = [
    'images/avatar1.jpg',
    'images/avatar2.jpg',
    'images/avatar3.jpg',
    'images/avatar4.jpg',
  ];
  int currentAvatarIndex = 0;

  String userName = "USERNAME"; // Replace with dynamic user data later
  int userLevel = 2000; // Replace with actual level data

  void nextAvatar() {
    setState(() {
      currentAvatarIndex = (currentAvatarIndex + 1) % avatarImages.length;
    });
  }

  void previousAvatar() {
    setState(() {
      currentAvatarIndex =
          (currentAvatarIndex - 1 + avatarImages.length) % avatarImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar Image with Left & Right Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left Button
            IconButton(
              icon: Icon(Icons.arrow_left, size: 40, color: Colors.blue),
              onPressed: previousAvatar,
            ),

            // Avatar Stack (Borders + Image)
            Stack(
              alignment: Alignment.center,
              children: [
                // Outer White Border
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 6),
                  ),
                ),
                // Inner Blue Border
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 4),
                  ),
                ),
                // Avatar Image
                ClipOval(
                  child: Image.asset(
                    avatarImages[currentAvatarIndex],
                    width: 144,
                    height: 144,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // Right Button
            IconButton(
              icon: Icon(Icons.arrow_right, size: 40, color: Colors.blue),
              onPressed: nextAvatar,
            ),
          ],
        ),

        SizedBox(height: 10),

        // Name & Level Display
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.purple[600],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            userName,
            style: GoogleFonts.micro5(
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue[700],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "LEVEL - $userLevel",
            style: GoogleFonts.micro5(
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 10),

        // Change Avatar Button (Center)
      ],
    );
  }
}
