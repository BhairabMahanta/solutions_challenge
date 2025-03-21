import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyCVyDUW8UYtLkd9Um9dHq2YqxsFcvlMTVc";
  static const String modelName = "gemini-1.5-flash"; // Or "gemini-1.5-pro"
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1/models/$modelName:generateContent";

  static Future<String> getResponse(String prompt) async {
    print("🔵 Sending request: $prompt");

    final response = await http.post(
      Uri.parse("$apiUrl?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": "You are GreenPath, an AI assistant dedicated to reducing GHG emissions. "
                    "Provide actionable, fact-based responses in a concise manner.\n\nUser: $prompt"
              }
            ]
          }
        ],
        "generationConfig": {
          "temperature": 0.2, // Low = More factual
          "top_k": 30,
          "top_p": 0.9
        }
      }),
    );

    print("🟢 Response Status: ${response.statusCode}");
    print("🟡 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['candidates'] != null &&
          data['candidates'].isNotEmpty &&
          data['candidates'][0]['content']?['parts']?.isNotEmpty == true) {
        return data['candidates'][0]['content']['parts'][0]['text'] ??
            "No response";
      } else {
        return "⚠️ No response from the AI.";
      }
    } else {
      return "❌ Error: ${response.statusCode} - ${response.body}";
    }
  }
}
