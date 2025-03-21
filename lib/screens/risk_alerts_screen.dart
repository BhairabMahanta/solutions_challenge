import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiskAlertsScreen extends StatefulWidget {
  @override
  _RiskAlertsScreenState createState() => _RiskAlertsScreenState();
}

class _RiskAlertsScreenState extends State<RiskAlertsScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<String> alerts = [];
  bool isLoading = false;

  Future<void> fetchWeatherAlerts(String location) async {
    setState(() {
      isLoading = true;
    });

    final String apiKey = 'YOUR_API_KEY';
    final String apiUrl =
        'https://api.weatherapi.com/v1/alerts.json?key=$apiKey&q=$location';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming API provides an "alerts" array with relevant weather messages.
        final List<dynamic> alertsData = data['alerts'] ?? [];
        setState(() {
          alerts = alertsData
              .map<String>((alert) =>
                  alert['description']?.toString() ??
                  "No description available.")
              .toList();
        });
      } else {
        setState(() {
          alerts = ["Failed to fetch weather alerts. Please try again later."];
        });
      }
    } catch (error) {
      setState(() {
        alerts = ["Error fetching alerts: $error"];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText('Risk Alerts & Preparedness Tips'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter Location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_locationController.text.isNotEmpty) {
                      fetchWeatherAlerts(_locationController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: alerts.isNotEmpty
                        ? ListView.builder(
                            itemCount: alerts.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SelectableText(
                                    alerts[index],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: SelectableText('No alerts available.'),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
