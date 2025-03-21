import 'package:flutter/material.dart';
import '../../../widgets/info_card.dart';

class MitigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building MitigationScreen");
    return Scaffold(
      appBar: AppBar(
        title: SelectableText("Mitigation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InfoCard(
              title: "Carbon Footprint Calculator",
              content: "Estimate your emissions based on your usage.",
            ),
            // Add more widgets and functionality as needed.
          ],
        ),
      ),
    );
  }
}
