import 'package:flutter/material.dart';
import 'package:new_solution/widgets/carbon_calculator/carbon_result..dart';
import 'carbon_data.dart';

class CarbonQuiz extends StatefulWidget {
  @override
  _CarbonQuizState createState() => _CarbonQuizState();
}

class _CarbonQuizState extends State<CarbonQuiz> {
  int _currentQuestionIndex = 0;
  List<double> _userResponses = List.filled(CarbonData.questions.length, 0.0);

  void _nextQuestion(double score) {
    setState(() {
      _userResponses[_currentQuestionIndex] = score;
      if (_currentQuestionIndex < CarbonData.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        double finalScore = CarbonData.calculateScore(_userResponses);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarbonResult(score: finalScore),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = CarbonData.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Carbon Footprint Quiz")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${_currentQuestionIndex + 1} of ${CarbonData.questions.length}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              currentQuestion['question'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ...currentQuestion['options'].entries.map((option) {
              return ElevatedButton(
                onPressed: () => _nextQuestion(option.value),
                child: Text(option.key),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
