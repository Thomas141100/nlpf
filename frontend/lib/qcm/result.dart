import 'package:fht_linkedin/module/client.dart';
import 'package:flutter/material.dart';
import 'package:fht_linkedin/utils/utils.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final String mcqId;
  final int maxScore;

  const Result(this.mcqId, this.maxScore, this.resultScore, this.resetHandler,
      {Key? key})
      : super(key: key);

//Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 3 * (maxScore / 4)) {
      resultText = 'Félicitation !';
    } else if (resultScore >= 2 * (maxScore / 4)) {
      resultText = 'Vraiment pas mal';
    } else if (resultScore >= (maxScore / 4)) {
      resultText = 'Assez bien';
    } else if (resultScore >= 0) {
      resultText = 'Rien de bien fou';
    } else {
      resultText = 'Dur dur';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              resultPhrase,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ), //Text
            Text(
              'Score ' '$resultScore',
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                var response = await Client.savemcq(mcqId, resultScore);
                if (response.statusCode == 200) {
                  showSnackBar(context, "mcq sauvegardé");
                  Navigator.of(context).pop();
                } else {
                  showSnackBar(context, "Une erreur est survenu :[",
                      isError: true);
                }
                Navigator.of(context).pop();
                resetHandler();
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Retour',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
