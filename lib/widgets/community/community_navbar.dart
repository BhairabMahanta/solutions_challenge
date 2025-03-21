import 'package:flutter/material.dart';

class CommunityNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Frame Title
          Text("Frame", style: TextStyle(color: Colors.white, fontSize: 20)),

          // Middle: Navigation Buttons
          Row(
            children: [
              _navButton("My Channels"),
              SizedBox(width: 10),
              _navButton("Create"),
            ],
          ),

          // Right Side: Extra Options
          Row(
            children: [
              _navButton("Add Friends", icon: Icons.person_add),
              SizedBox(width: 10),
              _navButton("Leaderboards", icon: Icons.emoji_events),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(String title, {IconData? icon}) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: Colors.grey[900],
      ),
      onPressed: () {},
      icon:
          icon != null ? Icon(icon, size: 18, color: Colors.white) : SizedBox(),
      label: Text(title),
    );
  }
}
