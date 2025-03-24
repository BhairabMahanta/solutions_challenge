import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyCVyDUW8UYtLkd9Um9dHq2YqxsFcvlMTVc";
  static const String modelName =
      "gemini-1.5-flash"; // Use "gemini-1.5-pro" if needed
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1/models/$modelName:generateContent";

  static Future<String> getTravelSuggestions(
      String personalityType, String travelMode) async {
    print(
        "🔵 Fetching AI travel insights for $personalityType using $travelMode...");

    String prompt = """
You are a sustainability expert helping users calculate their carbon footprint. 
Instead of answering directly, **generate follow-up questions** to gather precise details.

### **Context**
- The user is a **$personalityType**.
- Their primary transport mode is **$travelMode**.

### **Instructions**
1️⃣ Identify **common destinations** they might travel to.
2️⃣ Generate **specific follow-up questions** as multiple-choice options.
3️⃣ Allow the user to input additional places if necessary.

### **Example Output Format**
- **Question:** How far is your college/university?  
  - (Options: "Less than 1 km", "1-5 km", "5-10 km", "More than 10 km")  
- **Question:** How far is your nearest grocery store?  
  - (Options: "Less than 500m", "500m-2km", "More than 2km")  
- **Question:** What other places do you regularly visit?  
  - (User can enter custom locations)  

Return the response in a structured format so it can be converted into clickable buttons.
""";

    final response = await http.post(
      Uri.parse("$apiUrl?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ],
        "generationConfig": {"temperature": 0.3, "top_k": 40, "top_p": 0.85}
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] ??
          "No AI response.";
    } else {
      return "❌ AI Error: ${response.statusCode} - ${response.body}";
    }
  }
}
