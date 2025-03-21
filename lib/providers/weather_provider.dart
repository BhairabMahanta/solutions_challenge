import 'package:flutter/material.dart';

class Weather {
  final double temperature;
  final String description;
  final String city;

  Weather({
    required this.temperature,
    required this.description,
    required this.city,
  });
}

class WeatherProvider with ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather() async {
    try {
      // Mock API response (Replace with actual API call)
      await Future.delayed(Duration(seconds: 2));
      _weather = Weather(
        temperature: 75.0,
        description: "Sunny",
        city: "New York",
      );
      notifyListeners();
      print("Weather data fetched successfully.");
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }
}
