import 'package:flutter/material.dart';
import 'package:new_solution/widgets/carbon_calculator/carbon_result.dart';
import 'carbon_data.dart';

class CarbonQuiz extends StatefulWidget {
  @override
  _CarbonQuizState createState() => _CarbonQuizState();
}

class _CarbonQuizState extends State<CarbonQuiz> {
  int _currentQuestionIndex = 0;
  List<double> _userResponses = List.filled(CarbonData.questions.length, 0.0);

  void _selectAnswer(double score) {
    setState(() {
      _userResponses[_currentQuestionIndex] = score;
    });
  }

  void _goToNext() {
    if (_currentQuestionIndex < CarbonData.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      double finalScore = CarbonData.calculateScore(_userResponses);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarbonResult(score: finalScore),
        ),
      );
    }
  }

  void _goToPrevious() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _jumpToQuestion(int? index) {
    if (index != null) {
      setState(() {
        _currentQuestionIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = CarbonData.questions[_currentQuestionIndex];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Navigation Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28),
                  onPressed: _goToPrevious,
                ),
                DropdownButton<int>(
                  value: _currentQuestionIndex,
                  items: List.generate(
                    CarbonData.questions.length,
                    (index) => DropdownMenuItem<int>(
                      value: index,
                      child: Text("Q${index + 1}"),
                    ),
                  ),
                  onChanged: _jumpToQuestion,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward, size: 28),
                  onPressed: _goToNext,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Question Info
            Text(
              "Question ${_currentQuestionIndex + 1} of ${CarbonData.questions.length}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),

            // Question Text
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                currentQuestion['question'],
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Answer Options
            Column(
              children: (currentQuestion['options'] as Map<String, double>)
                  .entries
                  .map<Widget>((option) {
                // Explicitly specify <Widget>
                bool isSelected =
                    _userResponses[_currentQuestionIndex] == option.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isSelected ? Colors.green.shade400 : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: isSelected ? 4 : 2,
                    ),
                    onPressed: () => _selectAnswer(option.value),
                    child: Text(
                      option.key,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(), // Fix: Ensure it's converted to List<Widget>
            ),
            const SizedBox(height: 20),

            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _goToNext,
                child: Text(
                  _currentQuestionIndex == CarbonData.questions.length - 1
                      ? "See Results"
                      : "Next",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
