import 'package:flutter/material.dart';

class ComingSoonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures full width
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Avoids unnecessary extra space
        children: [
          Text(
            "Coming Soon",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "We're working on exciting new features to help you track and reduce your environmental impact.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text("- Personal carbon footprint calculator"),
        ],
      ),
    );
  }
}
