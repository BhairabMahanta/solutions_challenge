import 'dart:convert';
import 'package:http/http.dart' as http;

class ClimateService {
  static const String apiKey = 'd834ca5113454314af895134250802';
  static const String apiUrl =
      'http://api.worldweatheronline.com/premium/v1/weather.ashx';
  static const String searchUrl =
      'http://api.worldweatheronline.com/premium/v1/search.ashx';

  Future<Map<String, dynamic>> fetchClimateStats(String location) async {
    final Uri url = Uri.parse('$apiUrl?key=$apiKey&q=$location&format=json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? {};
      } else {
        return {'error': "Error fetching data. Status: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "An error occurred: $e"};
    }
  }

  Future<List<String>> fetchLocationSuggestions(String query) async {
    if (query.isEmpty) return [];

    final Uri url = Uri.parse('$searchUrl?key=$apiKey&q=$query&format=json');
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
