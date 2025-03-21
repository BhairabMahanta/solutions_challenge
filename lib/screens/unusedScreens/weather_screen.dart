import 'package:flutter/material.dart';
import '../../services/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherAPI weatherAPI = WeatherAPI();
  String city = "Guwahati";
  String weatherDescription = "Loading...";
  String riskAlert = "";

  @override
  void initState() {
    super.initState();
    fetchWeatherAndAlert();
  }

  Future<void> fetchWeatherAndAlert() async {
    try {
      final weatherData = await weatherAPI.fetchWeatherData(city);
      setState(() {
        weatherDescription =
            "${weatherData['weather'][0]['description']} at ${weatherData['main']['temp']}°C";

        // Simple alert logic
        if (weatherData['weather'][0]['main'].toLowerCase().contains("rain")) {
          riskAlert = "Heavy rainfall expected. Avoid travel.";
        } else if (weatherData['main']['temp'] > 35) {
          riskAlert = "Heatwave warning. Stay hydrated.";
        } else {
          riskAlert = "Weather looks clear. Stay safe.";
        }
      });
    } catch (e) {
      setState(() {
        weatherDescription = "Error fetching weather data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText('Weather & Alerts'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              "Weather in $city",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SelectableText(weatherDescription, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SelectableText(
              "Risk Alert:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SelectableText(
              riskAlert,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
