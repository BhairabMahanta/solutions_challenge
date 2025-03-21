import 'package:flutter/material.dart';

class CommunitySidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.black.withOpacity(0.7), // Adjust opacity for effect
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                  'images/google.png'), //'assets/user_${index + 1}.png'
            ),
          );
        }),
      ),
    );
  }
}
