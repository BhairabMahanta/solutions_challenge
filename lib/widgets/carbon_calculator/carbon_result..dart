import 'package:flutter/material.dart';

class CarbonResult extends StatelessWidget {
  final double score;

  CarbonResult({required this.score});

  String getCategory() {
    if (score < 10) return "🌱 Low Impact (Great Job!)";
    if (score < 20) return "🌍 Moderate Impact (Could Improve)";
    return "🔥 High Impact (Try Reducing)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carbon Footprint Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Carbon Footprint Score:",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              score.toStringAsFixed(1),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              getCategory(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Take Quiz Again"),
            ),
          ],
        ),
      ),
    );
  }
}
