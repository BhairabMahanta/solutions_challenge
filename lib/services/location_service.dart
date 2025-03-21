import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationService {
  static Future<Map<String, dynamic>> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {'error': 'Location services are disabled.'};
    }

    // ✅ Request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {'error': 'Location permission denied.'};
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {'error': 'Location permanently denied.'};
    }

    // ✅ Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }

  static Future<List<String>> getWeatherAlerts(double lat, double lon) async {
    String apiKey =
        "fdc18c3f8fc634bbb2e293f7f6c045af"; // 🔴 Replace with actual API key
    String url =
        "https://api.weatherapi.com/v1/alerts.json?key=$apiKey&q=$lat,$lon";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<String> alerts = [];
        if (data['alerts'] != null) {
          for (var alert in data['alerts']) {
            alerts.add(alert['headline']);
          }
        }
        return alerts;
      } else {
        return ['Failed to load alerts'];
      }
    } catch (e) {
      return ['Error: $e'];
    }
  }
}
