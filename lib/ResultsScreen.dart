import 'package:flutter/material.dart';
import 'ReviewScreen.dart';

class ResultsScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final List<Map<String, dynamic>> questions;
  final List<String?> selectedAnswers;

  ResultsScreen({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'You answered $correctAnswers out of $totalQuestions correctly!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewScreen(
                      questions: questions,
                      selectedAnswers: selectedAnswers,
                    ),
                  ),
                );
              },
              child: Text('Review Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
