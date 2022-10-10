class MCQ {
  int maxScore = 0;
  int expectedScore = 0;
  List<Map<String, Object>> questions = List.empty(growable: true);

  MCQ(this.maxScore, this.expectedScore, this.questions);

  MCQ.fromJson(Map<dynamic, dynamic> json) {
    maxScore = json['maxScore'];
    expectedScore = json['expectedScore'];
    // questions = json['questions'];
    var questionsJson = json['questions'];
    List<Map<String, Object>> quests = [];
    for (var i = 0; i < questionsJson.length; i++) {
      quests.add({
        'question': (questionsJson[i] as Map<String, dynamic>)['questionText'],
        'answers': (questionsJson[i] as Map<String, dynamic>)['answers'],
      });
    }
    questions = quests;
  }

  MCQ.empty() : this(0, 0, []);
}
