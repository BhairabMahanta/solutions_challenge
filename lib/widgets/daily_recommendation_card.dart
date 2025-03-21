import 'package:flutter/material.dart';

class DailyRecommendationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green.shade100, // Matches the theme
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🌿 Daily Recommendation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Plant a tree today! 🌱 A small effort can make a big impact on the environment.",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
