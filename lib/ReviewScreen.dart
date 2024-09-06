import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  final List<String?> selectedAnswers;

  ReviewScreen({
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Quiz'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${index + 1}: ${questions[index]['question']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...questions[index]['options']!.map<Widget>((option) {
                  Color textColor;
                  if (option == questions[index]['answer']) {
                    textColor = Colors.green;
                  } else if (option == selectedAnswers[index]) {
                    textColor = Colors.red;
                  } else {
                    textColor = Colors.black;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  );
                }).toList(),
                Divider(thickness: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
