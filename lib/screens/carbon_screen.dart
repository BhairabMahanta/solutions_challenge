import 'package:flutter/material.dart';
import '../utils/carbon_caluclator.dart'; // Ensure this path is correct.
import '../widgets/custom_button.dart';

class CarbonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building Improved CarbonScreen");
    return Scaffold(
      appBar: AppBar(
        title: SelectableText("Climate Action Dashboard"),
        backgroundColor: Color.fromARGB(255, 158, 223, 166),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.green.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Header Section
                    SelectableText(
                      "Welcome to Climate Action",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    SelectableText(
                      "Take steps to reduce your carbon footprint and protect our planet.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    // Mitigation Section with Carbon Calculator
                    Card(
                      elevation: 4,
                      color: Color.fromARGB(255, 158, 223, 166),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              "Mitigation: Carbon Footprint Calculator",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            SelectableText(
                              "Enter your daily travel details to calculate your CO2 emissions. Get personalized recommendations to lower your emissions.",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            // Embed the CarbonCalculator widget
                            CarbonCalculator(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Button to navigate to Adaptation features

                    CustomButton(
                      label: "Explore Adaptation Features",
                      onPressed: () {
                        print("Navigating to Adaptation Screen");
                        Navigator.pushNamed(context, '/adaptation');
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
