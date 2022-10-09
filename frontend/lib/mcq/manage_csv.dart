class ManageCSV {
  String titre = '';
  String mcqID = '';
  int maxScore = 0;
  List<Map<String, Object>> questions = [];

  bool parseCsv(String csv) {
    //parse csv file
    var parsedCsv = csv
        .split("\r")
        .map((row) => row.split(';'))
        .map((row) => row.map((cell) => cell.trim()).toList())
        .toList();

    titre = parsedCsv[0][0];
    maxScore = int.parse(parsedCsv[0][1]);

    var trimmedCsv = parsedCsv.sublist(1, parsedCsv.length - 1);

    trimmedCsv.forEach((element) {
      //element = [question, answer1, score1, answer2, score2, answer3, score3, answer4, score3]
      var question = {
        'questionText': element[0],
        'answers': [
          {'text': element[1], 'score': int.parse(element[2])},
          {'text': element[3], 'score': int.parse(element[4])},
          {'text': element[5], 'score': int.parse(element[6])},
          {'text': element[7], 'score': int.parse(element[8])},
        ],
      };
      questions.add(question);
    });
    return true;
  }
}
