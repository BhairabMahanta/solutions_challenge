import 'dart:convert';
import 'package:new_solution/services/gemini_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DailyTasksService {
  Future<List<Map<String, String>>> fetchDailyTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString("user");

    List<String> tasks;
    if (storedData != null) {
      Map<String, dynamic> userData = jsonDecode(storedData);
      tasks = _generatePersonalizedTasks(userData);
    } else {
      tasks = _defaultTasks();
    }

    return await _fetchTaskExplanations(tasks);
  }

  List<String> _generatePersonalizedTasks(Map<String, dynamic> userData) {
    List<String> tasks = [];

    if (userData.containsKey("travel")) {
      var travelData = List<Map<String, dynamic>>.from(userData["travel"]);

      for (var item in travelData) {
        double distance =
            double.tryParse(item["distance_km"].toString()) ?? 0.0;
        if (distance > 10) {
          tasks.add(
              "Consider using public transport instead of personal vehicles.");
        }
        if (distance < 2) {
          tasks.add("Try walking or cycling for short distances.");
        }
      }
    }

    if (userData.containsKey("energy")) {
      var energyData = List<Map<String, dynamic>>.from(userData["energy"]);

      for (var item in energyData) {
        int hours = int.tryParse(item["hours"].toString()) ?? 0;
        if (hours > 5) {
          tasks.add(
              "Turn off ${item["device"]} when not in use to save energy.");
        }
        if (item["device"] == "Refrigerator") {
          tasks.add(
              "Keep your refrigerator at an optimal temperature to reduce energy waste.");
        }
      }
    }

    if (tasks.isEmpty) {
      tasks = _defaultTasks();
    }

    return tasks;
  }

  List<String> _defaultTasks() {
    return [
      "Recycle plastic waste",
      "Bike instead of drive",
      "Use a reusable bottle",
      "Turn off unnecessary lights",
      "Reduce water waste while washing"
    ];
  }

  Future<List<Map<String, String>>> _fetchTaskExplanations(
      List<String> tasks) async {
    List<Map<String, String>> taskWithReasons = [];

    for (String task in tasks) {
      String explanation = await _getTaskExplanation(task);
      taskWithReasons.add({"task": task, "reason": explanation});
    }

    return taskWithReasons;
  }

  Future<String> _getTaskExplanation(String task) async {
    try {
      const String modelName = "gemini-1.5-flash";
      final String apiUrl =
          "https://generativelanguage.googleapis.com/v1/models/$modelName:generateContent";

      print("📤 Sending Task to Gemini: $task");

      Map<String, dynamic> requestBody = {
        "contents": [
          {
            "role": "user",
            "parts": [
              {
                "text":
                    "Explain why this task is environmentally beneficial in a single line: $task"
              }
            ]
          }
        ],
        "generationConfig": {"temperature": 0.2, "top_k": 30, "top_p": 0.9}
      };

      print("📦 Request Body: ${jsonEncode(requestBody)}");

      final response = await http.post(
        Uri.parse("$apiUrl?key=${GeminiService.apiKey}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      print("📥 Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.containsKey("candidates") &&
            data["candidates"].isNotEmpty &&
            data["candidates"][0].containsKey("content") &&
            data["candidates"][0]["content"].containsKey("parts") &&
            data["candidates"][0]["content"]["parts"].isNotEmpty &&
            data["candidates"][0]["content"]["parts"][0].containsKey("text")) {
          String explanation =
              data["candidates"][0]["content"]["parts"][0]["text"];

          print("✅ Explanation Received: $explanation");
          return explanation;
        } else {
          print("⚠️ Unexpected response structure: $data");
        }
      } else {
        print("❌ API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("❌ Gemini API Exception: $e");
    }

    print("⚠️ Returning Fallback Message");
    return "This task helps the environment by reducing its carbon footprint and promoting sustainability.";
  }
}
