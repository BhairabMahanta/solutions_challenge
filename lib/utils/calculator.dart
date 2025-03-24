import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EmissionCalculator {
  // Travel CO₂ emissions per km
  static Map<String, double> travelEmissionRates = {
    "Domestic flight": 246.0,
    "Diesel car": 171.0,
    "Petrol car": 170.0,
    "Short-haul flight": 151.0,
    "Long-haul flight": 148.0,
    "Motorbike": 114.0,
    "Bus": 97.0,
    "Bus (local London)": 79.0,
    "Plug-in hybrid": 68.0,
    "Electric car": 47.0,
    "National rail": 35.0,
    "Tram": 29.0,
    "London Underground": 28.0,
    "Coach (bus)": 27.0,
    "Ferry (foot passenger)": 19.0,
    "Eurostar (to Paris)": 4.0,
    "Bicycle": 0.0,
    "Walking": 0.0
  };

  // Energy CO₂ emissions per hour
  static Map<String, List<int>> energyEmissionRates = {
    "Refrigerator": [94, 328],
    "Electric Stove": [455, 1950],
    "Laptop/Desktop Computer": [52, 234]
  };

  // Function to load travel & energy data from SharedPreferences and calculate emissions
  static Future<Map<String, double>> calculateEmissions() async {
    final prefs = await SharedPreferences.getInstance();

    // Load and decode travel data
    List<Map<String, dynamic>> travelData = [];
    String? travelJson = prefs.getString("travel_data");
    if (travelJson != null) {
      var decoded = jsonDecode(travelJson);
      if (decoded is Map && decoded.containsKey("user")) {
        travelData = List<Map<String, dynamic>>.from(decoded["user"]["travel"]);
      }
    }

    // Load and decode energy data
    List<Map<String, dynamic>> energyData = [];
    String? energyJson = prefs.getString("energy_data");
    if (energyJson != null) {
      var decoded = jsonDecode(energyJson);
      if (decoded is Map && decoded.containsKey("user")) {
        energyData = List<Map<String, dynamic>>.from(decoded["user"]["energy"]);
      }
    }

    // Calculate travel CO₂ emissions
    double totalTravelCO2 = 0;
    for (var entry in travelData) {
      String mode = entry["mode"];
      double distance = entry["distance_km"]?.toDouble() ?? 0.0;
      double co2PerKm = travelEmissionRates[mode] ?? 0.0;
      totalTravelCO2 += distance * co2PerKm;
    }

    // Calculate energy CO₂ emissions
    double totalEnergyCO2 = 0;
    for (var entry in energyData) {
      String device = entry["device"];
      int hours = entry["hours"] ?? 0;

      // Get emission rate: Take the average of min/max values if available
      List<int>? co2Range = energyEmissionRates[device];
      if (co2Range != null) {
        int co2PerHour = ((co2Range[0] + co2Range[1]) / 2).round();
        totalEnergyCO2 += hours * co2PerHour;
      }
    }

    return {
      "travelCO2": totalTravelCO2,
      "energyCO2": totalEnergyCO2,
    };
  }
}
