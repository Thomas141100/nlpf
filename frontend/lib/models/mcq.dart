class MCQ {
  int maxScore = 0;
  int expectedScore = 0;
  List<Map<String, Object>> questions = [];

  MCQ(this.maxScore, this.expectedScore, this.questions);

  MCQ.fromJson(Map<dynamic, dynamic> json)
      : maxScore = json['maxScore'],
        expectedScore = json['expectedScore'],
        questions = json['questions'];

  MCQ.empty() : this(0, 0, []);
}
