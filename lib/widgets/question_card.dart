import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/utils/gradient_decorations.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedOptionIndex;
  final bool showCorrectAnswer;
  final void Function(int) onOptionSelected;
  final double height;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedOptionIndex,
    required this.showCorrectAnswer,
    required this.onOptionSelected,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height - 110,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: height * 0.4,
            width: double.infinity,
            padding: EdgeInsets.all(10).copyWith(bottom: 0),
            decoration: radialGradient,
            child: SingleChildScrollView(
              child: Text(
                question.description,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                final optionID = ['A', 'B', 'C', 'D'][index];
                final option = question.options[index];
                Color? backgroundColor;

                if (selectedOptionIndex != null) {
                  if (selectedOptionIndex == index) {
                    backgroundColor =
                        option.isCorrect ? Colors.green : Colors.red;
                  } else if (option.isCorrect) {
                    backgroundColor = Colors.green;
                  }
                }
                return GestureDetector(
                  onTap: () => onOptionSelected(index),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('$optionID.'),
                            const SizedBox(width: 25),
                            Text(option.description),
                          ],
                        ),
                        if (selectedOptionIndex != null &&
                            selectedOptionIndex == index)
                          Icon(
                            option.isCorrect ? Icons.done : Icons.close,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
