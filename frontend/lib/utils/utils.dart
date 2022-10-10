import 'package:fht_linkedin/models/job_offer.dart';
import 'package:flutter/material.dart';

import '../models/mcq.dart';

void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 1500),
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    width: 350,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

JobOffer convertJson2JobOffer(Map<dynamic, dynamic> json) {
  List<Map<String, Object>> questions = [];
  var arr = json['mcq']?['questions'];
  arr.forEach((element) {
    var questionText = element['questionText'];
    var answers = element['answers'];
    questions.add({
      'questionText': questionText,
      'answers': answers,
    });
  });

  MCQ mcq = MCQ(
    json['mcq']['maxScore'],
    json['mcq']['expectedScore'],
    questions,
  );

  var newJobOffer = JobOffer(
      json['_id'].toString(),
      json['title'].toString(),
      json['employer'].toString(),
      json['companyname'].toString(),
      null,
      [json['tags']],
      json['description'],
      mcq);
  return newJobOffer;
}
