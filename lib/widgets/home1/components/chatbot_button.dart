import 'package:flutter/material.dart';
import 'package:new_solution/widgets/chatbot_overlay.dart';

Widget chatbotButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      ChatbotPopup.show(context);
    },
    style: TextButton.styleFrom(
      backgroundColor: Colors.green[400],
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    child: Text("Sherpa AI"),
  );
}
