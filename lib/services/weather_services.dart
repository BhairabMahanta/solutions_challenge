import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPI {
  final String apiKey = "fdc18c3f8fc634bbb2e293f7f6c045af";

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to fetch weather data");
      }
    } catch (error) {
      throw error;
    }
  }
}
