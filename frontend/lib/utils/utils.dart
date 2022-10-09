import 'package:fht_linkedin/models/candidacy.dart';
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
  arr?.forEach((element) {
    var questionText = element['questionText'];
    var answers = element['answers'];
    questions.add({
      'questionText': questionText,
      'answers': answers,
    });
  });

  MCQ? mcq = arr != null
      ? MCQ(
          json['mcq']['maxScore'],
          json['mcq']['expectedScore'],
          questions,
        )
      : null;

  var newJobOffer = JobOffer(
      json['_id'].toString(),
      json['title'].toString(),
      json['employer'].toString(),
      json['companyName'].toString(),
      json['candidacies'] != null
          ? List<String>.from(json['candidacies'] as List<dynamic>)
          : null,
      [json['tags']],
      json['description'],
      mcq);
  return newJobOffer;
}

UserCandidacy convertJson2UserCandidacy(Map<dynamic, dynamic> json) {
  var userCandidacy = UserCandidacy(json['_id'], json['candidate'],
      convertJson2JobOffer(json['offer']), json['creationDate']);
  return userCandidacy;
}
