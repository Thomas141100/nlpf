import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 650,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Question(
              questions[questionIndex]['questionText'].toString(),
            ),
            ...(questions[questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Answer(
                  () => answerQuestion(answer['score']),
                  answer['text'].toString(),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
