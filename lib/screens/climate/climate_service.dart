import 'dart:convert';
import 'package:http/http.dart' as http;

class ClimateService {
  // 🌍 Weather API (World Weather Online)
  static const String weatherApiKey = 'd834ca5113454314af895134250802';
  static const String weatherApiUrl =
      'http://api.worldweatheronline.com/premium/v1/weather.ashx';
  static const String searchUrl =
      'http://api.worldweatheronline.com/premium/v1/search.ashx';

  // 🌫 Air Quality API (OpenWeather)
  static const String airQualityApiKey = 'be04239ecc2ebb174ef857cd932a630b';
  static const String airQualityApiUrl =
      'http://api.openweathermap.org/data/2.5/air_pollution';

  // 🌍 Fetch Weather Data
  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final Uri url =
        Uri.parse('$weatherApiUrl?key=$weatherApiKey&q=$location&format=json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? {};
      } else {
        return {'error': "Weather API Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Weather API Error: $e"};
    }
  }

  // 🌫 Fetch Air Quality Data (AQI)
  Future<Map<String, dynamic>> fetchAirQuality(double lat, double lon) async {
    final Uri url = Uri.parse(
        '$airQualityApiUrl?lat=$lat&lon=$lon&appid=$airQualityApiKey');

    print("🌫 Fetching Air Quality Data from: $url");

    try {
      final response = await http.get(url);
      print("📩 Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        print("📜 Decoded API Response: $decodedData");

        if (decodedData is Map<String, dynamic>) {
          final List<dynamic> list = decodedData['list'] ?? [];

          if (list.isNotEmpty) {
            final airQualityData = Map<String, dynamic>.from(list[0]);
            print("✅ Parsed Air Quality Data: $airQualityData");
            return airQualityData;
          } else {
            print("⚠️ Empty AQI List in API Response.");
            return {'error': "AQI data is empty"};
          }
        } else {
          print("⚠️ Unexpected API response format.");
          return {'error': "Unexpected response format"};
        }
      } else {
        print("❌ AQI API Error: ${response.statusCode}");
        return {'error': "AQI API Error: ${response.statusCode}"};
      }
    } catch (e) {
      print("❌ Exception while fetching AQI: $e");
      return {'error': "AQI API Error: $e"};
    }
  }

  // 🔄 Fetch Combined Climate Data
  Future<Map<String, dynamic>> fetchClimateStats(String location) async {
    final weatherData = await fetchWeather(location);

    // Extract city name from request
    String? cityName;
    double? lat;
    double? lon;

    if (weatherData.containsKey('request') &&
        weatherData['request'] is List &&
        weatherData['request'].isNotEmpty) {
      final requestData = weatherData['request'][0];

      cityName = requestData['query'].toString(); // Extract city name
      print("📍 City Name: $cityName");
    }

    // Use cityName to fetch lat/lon if needed
    if (cityName != null) {
      final locationData = await fetchLocationSuggestions(cityName);
      if (locationData.isNotEmpty) {
        print("🌍 Found Location: ${locationData.first}");
        // Assuming the first result is the most relevant one
        final latLonData =
            locationData.first.split(','); // Example: "26.1445,91.7362"
        if (latLonData.length == 2) {
          lat = double.tryParse(latLonData[0]);
          lon = double.tryParse(latLonData[1]);
        }
      }
    }

    print("📍 Extracted Coordinates: lat=$lat, lon=$lon");

    // Ensure airQualityData is always Map<String, dynamic>
    final Map<String, dynamic> airQualityData =
        (lat != null && lon != null) ? await fetchAirQuality(lat, lon) : {};

    return {
      ...weatherData, // Keep original API structure
      'city': cityName,
      'air_quality': airQualityData,
      'lifestyle_tips': getLifestyleTips(airQualityData),
    };
  }

  Future<List<String>> fetchLocationSuggestions(String query) async {
    if (query.isEmpty) return [];

    final Uri url =
        Uri.parse('$searchUrl?key=$weatherApiKey&q=$query&format=json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['search_api']?['result'] ?? [];
        return results
            .map<String>((item) => item['areaName'][0]['value'].toString())
            .toList();
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}

// ✅ Generate Lifestyle Tips Based on AQI
List<String> getLifestyleTips(Map<String, dynamic> aqiData) {
  if (aqiData.isEmpty || aqiData['main'] == null) {
    return ["No AQI data available."];
  }

  int aqi = aqiData['main']['aqi'] ?? 0;
  if (aqi == 1) return ["Great air quality! Enjoy outdoor activities."];
  if (aqi == 2)
    return [
      "Air is moderate. People with sensitivities should limit exposure."
    ];
  if (aqi == 3) return ["Unhealthy air. Avoid long outdoor activities."];
  if (aqi == 4) return ["Very unhealthy. Stay indoors as much as possible."];
  if (aqi == 5) return ["Hazardous! Wear a mask if stepping outside."];

  return ["No AQI data available."];
}
