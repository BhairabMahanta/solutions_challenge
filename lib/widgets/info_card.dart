import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building InfoCard for: $title");
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SelectableText(content),
          ],
        ),
      ),
    );
  }
}
