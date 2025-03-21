import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';

class AdaptationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building AdaptationScreen");
    return Scaffold(
      appBar: AppBar(
        title: SelectableText("Adaptation"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InfoCard(
              title: "Risk Alerts & Preparedness",
              content:
                  "Stay updated with local risk alerts and preparedness tips.",
            ),
            // Add more widgets and functionality as needed.
          ],
        ),
      ),
    );
  }
}
