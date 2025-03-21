import 'package:flutter_tts/flutter_tts.dart';
import '../services/gemini_service.dart';
import '../widgets/chatbot_overlay.dart';
import 'package:flutter/material.dart'; // ✅ Add this import

class ChatbotLogic {
  static final FlutterTts flutterTts = FlutterTts();
  static bool isListening = false;

  static void sendMessage(
    String message,
    Function setState,
    TextEditingController controller,
  ) async {
    if (message.trim().isEmpty) return;

    setState(() {
      ChatbotPopup.messages.add({"role": "user", "text": message});
    });

    controller.clear();

    String response = await GeminiService.getResponse(message);

    setState(() {
      ChatbotPopup.messages.add({"role": "ai", "text": response});
    });

    await flutterTts.speak(response);
  }
}
