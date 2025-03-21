import 'package:flutter/material.dart';
import '../services/emission_calculator.dart'; // Ensure you have this file and function

class CarbonCalculator extends StatefulWidget {
  @override
  _CarbonCalculatorState createState() => _CarbonCalculatorState();
}

class _CarbonCalculatorState extends State<CarbonCalculator> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _factorController = TextEditingController();
  double? _result;

  void _calculateEmissions() {
    final distance = double.tryParse(_distanceController.text);
    final factor = double.tryParse(_factorController.text);
    if (distance != null && factor != null) {
      setState(() {
        _result = calculateEmissions(distance, factor);
      });
      print("Calculated emissions: $_result kg CO2");
    } else {
      print("Invalid input. Please enter numbers.");
    }
  }

  String getRecommendation(double emissions) {
    if (emissions > 100) {
      return "High emissions. Consider using public transport.";
    } else {
      return "Emissions are moderate. Good job!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText("Enter your distance traveled (km):"),
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "e.g., 50"),
            ),
            SizedBox(height: 16),
            SelectableText("Enter your emission factor (kg CO2/km):"),
            TextField(
              controller: _factorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "e.g., 0.2"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateEmissions,
              child: SelectableText("Calculate Emissions"),
            ),
            SizedBox(height: 16),
            if (_result != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                      "Your emissions: ${_result!.toStringAsFixed(2)} kg CO2"),
                  SizedBox(height: 8),
                  SelectableText(
                      "Recommendation: ${getRecommendation(_result!)}"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
