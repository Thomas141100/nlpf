class MCQ {
  int maxScore = 0;
  int expextedScore = 0;
  List<Map<String, Object>>? questions;

  MCQ(this.maxScore, this.expextedScore, this.questions);

  MCQ.empty() : this(0, 0, null);
}
