import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import '../utils/chatbot_logic.dart';

final stt.SpeechToText speechToText = stt.SpeechToText();

void pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    if (kIsWeb) {
      // Web: Use bytes instead of path
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      print("File selected: $fileName (Size: ${fileBytes?.length})");
      // Handle file processing with bytes here
    } else {
      // Mobile: Use file path
      File file = File(result.files.single.path!);
      print("File selected: ${file.path}");
      // Handle file upload logic here
    }
  }
}

void listen(Function setState, TextEditingController controller) async {
  if (!ChatbotLogic.isListening) {
    bool available = await speechToText.initialize(
      onError: (error) => print("Speech Error: $error"),
      debugLogging: true, // Helps debug issues
    );

    if (available) {
      setState(() => ChatbotLogic.isListening = true);
      speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            controller.text = result.recognizedWords;
            setState(() => ChatbotLogic.isListening = false);
          }
        },
      );
    } else {
      print("Speech-to-Text not available");
    }
  } else {
    setState(() => ChatbotLogic.isListening = false);
    speechToText.stop();
  }
}
