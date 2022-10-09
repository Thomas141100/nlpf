import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

class MCQForm extends StatefulWidget {
  final String mcqID;
  final int maxScore;
  final List<Map<String, Object>> questions;
  const MCQForm(
      {Key? key,
      required this.mcqID,
      required this.maxScore,
      required this.questions})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<MCQForm> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
          child: _questionIndex < widget.questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: widget.questions,
                )
              : Result(widget.mcqID, widget.maxScore, _totalScore, _resetQuiz),
        ),
      ],
    );
  }
}
