import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../services/gemini_service.dart'; // Ensure this file exists and is correctly set up

class ChatbotPopup {
  static List<Map<String, String>> messages = []; // Persistent message history
  static final FlutterTts flutterTts = FlutterTts();
  static final stt.SpeechToText speechToText = stt.SpeechToText();
  static bool isListening = false;

  static void show(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    FocusNode focusNode = FocusNode(); // For handling keyboard input

    List<String> suggestedQuestions = [
      "How can I reduce my carbon footprint?",
      "What are the best eco-friendly habits?",
      "How does transportation impact GHG emissions?",
      "What are some sustainable energy alternatives?",
    ];

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 750,
                  height: 800,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.auto_awesome,
                              size: 40, color: Colors.black87),
                          Text(
                            "Ask our AI anything",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.redAccent),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Suggested Questions Section
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: suggestedQuestions.map((question) {
                            return GestureDetector(
                              onTap: () {
                                sendMessage(
                                    question, setState, messageController);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  question,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Chat area
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                          ),
                          child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: messages[index]["role"] == "user"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: messages[index]["role"] == "user"
                                        ? Colors.blueAccent
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    messages[index]["text"]!,
                                    style: TextStyle(
                                      color: messages[index]["role"] == "user"
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Input area with buttons
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.3),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            // File Upload Button
                            IconButton(
                              icon:
                                  Icon(Icons.attach_file, color: Colors.green),
                              onPressed: () => pickFile(),
                            ),

                            // Microphone Button (For Voice Input)
                            IconButton(
                              icon: Icon(Icons.mic,
                                  color: isListening
                                      ? Colors.red
                                      : Colors.redAccent),
                              onPressed: () =>
                                  listen(setState, messageController),
                            ),

                            // Text Input Field
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: "Ask me anything...",
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {
                                  sendMessage(
                                      value, setState, messageController);
                                },
                              ),
                            ),

                            // Send Button
                            GestureDetector(
                              onTap: () {
                                sendMessage(messageController.text, setState,
                                    messageController);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withOpacity(0.2),
                                ),
                                child:
                                    Icon(Icons.send, color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void sendMessage(
    String message,
    Function setState,
    TextEditingController controller,
  ) async {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": message});
    });

    controller.clear();

    String response = await GeminiService.getResponse(message);

    setState(() {
      messages.add({"role": "ai", "text": response});
    });

    // Read AI response aloud
    await flutterTts.speak(response);
  }

  // Method to pick a file
  static void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print("File selected: ${file.path}");
      // Add file upload logic here
    }
  }

  // Method to handle voice input
  static void listen(
      Function setState, TextEditingController controller) async {
    if (!isListening) {
      bool available = await speechToText.initialize();
      if (available) {
        setState(() => isListening = true);
        speechToText.listen(
          onResult: (result) {
            if (result.finalResult) {
              controller.text = result.recognizedWords;
              setState(() => isListening = false);
            }
          },
        );
      }
    } else {
      setState(() => isListening = false);
      speechToText.stop();
    }
  }
}
