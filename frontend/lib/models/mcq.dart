class MCQ {
  int maxScore = 0;
  int expectedScore = 0;
  List<Map<String, Object>> questions = List.empty(growable: true);
  List<dynamic> answers = [];

  MCQ(this.maxScore, this.expectedScore, this.questions);

  MCQ.fromJson(Map<dynamic, dynamic> json) {
    if (json['mcq'] != null) {
      maxScore = json['mcq']['maxScore'];
      expectedScore = json['mcq']['expectedScore'];
      var questionsJson = json['mcq']['questions'];
      List<Map<String, Object>> quests = [];
      for (var i = 0; i < questionsJson.length; i++) {
        quests.add({
          'question':
              (questionsJson[i] as Map<String, dynamic>)['questionText'],
          'answers': (questionsJson[i] as Map<String, dynamic>)['answers'],
        });
      }
      answers = json['candidacies'] ?? [];
      questions = quests;
    } else {
      null;
    }
  }

  MCQ.empty() : this(0, 0, []);
}
