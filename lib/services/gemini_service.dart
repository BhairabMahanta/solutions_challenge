import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyCVyDUW8UYtLkd9Um9dHq2YqxsFcvlMTVc";
  static const String modelName =
      "gemini-1.5-flash"; // Use "gemini-1.5-pro" if needed
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1/models/$modelName:generateContent";

  // Store chat history for session retention
  static List<Map<String, String>> chatHistory = [];

  static Future<String> getResponse(String prompt) async {
    print("🔵 Sending request: $prompt");

    // Predefined system-level personalization
    String systemPrompt =
        "You are Sherpa AI of GreenStride, an advanced AI assistant developed by Team Pioneer. "
        "Your role is to assist users in reducing greenhouse gas (GHG) emissions and promoting sustainable solutions.\n\n"
        "🌍 **Climate Context**:\n"
        "Climate change threatens ecosystems, economies, and societies worldwide due to rising temperatures, extreme weather, and GHG emissions. "
        "Sectors like energy, transport, and urban development still rely on fossil fuels, exacerbating the crisis.\n\n"
        "🔬 **Challenges**:\n"
        "Participants in sustainability initiatives are working on **innovative, scalable, and inclusive solutions** for:\n"
        "- Reducing emissions 🌱\n"
        "- Enhancing climate resilience 🔄\n"
        "- Leveraging technology for sustainability 🛠️\n\n"
        "Your responses should:\n"
        "✅ Be concise, fact-driven, and solution-oriented.\n"
        "✅ Highlight cutting-edge technology & best practices.\n"
        "✅ Offer practical suggestions based on real-world application.\n\n"
        "🌟 **Eco-Health Quest Personalization**:\n"
        "- If the user asks about health-based tasks, incorporate eco-health quests (e.g., '10K Green Stride Badge: 10,000 steps burns 500 calories & saves 0.5kg CO₂').\n"
        "- For personalized alerts, provide actionable insights on health and sustainability.\n\n"
        "Now, respond to the user's query:\n\nUser: $prompt";

    // Add user query to chat history
    chatHistory.add({"role": "user", "text": prompt});

    final response = await http.post(
      Uri.parse("$apiUrl?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": systemPrompt}
            ]
          }
        ],
        "generationConfig": {"temperature": 0.2, "top_k": 30, "top_p": 0.9}
      }),
    );

    print("🟢 Response Status: ${response.statusCode}");
    print("🟡 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['candidates'] != null &&
          data['candidates'].isNotEmpty &&
          data['candidates'][0]['content']?['parts']?.isNotEmpty == true) {
        String aiResponse = data['candidates'][0]['content']['parts'][0]
                ['text'] ??
            "No response";

        // Add AI response to chat history
        chatHistory.add({"role": "ai", "text": aiResponse});

        return aiResponse;
      } else {
        return "⚠️ No response from the AI.";
      }
    } else {
      return "❌ Error: ${response.statusCode} - ${response.body}";
    }
  }

  // Function to get chat history for UI persistence
  static List<Map<String, String>> getChatHistory() {
    return chatHistory;
  }
}
