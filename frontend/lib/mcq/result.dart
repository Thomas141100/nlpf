import 'package:fht_linkedin/module/client.dart';
import 'package:flutter/material.dart';
import 'package:fht_linkedin/utils/utils.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final String offerId;
  final int maxScore;

  const Result(this.offerId, this.maxScore, this.resultScore, this.resetHandler,
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
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ), //Text
            Text(
              'Score ' '$resultScore',
               style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                var response = await Client.saveMCQ(offerId, resultScore);
                if (response.statusCode == 200) {
                  showSnackBar(context, "mcq sauvegardé");
                } else {
                  showSnackBar(context, "Une erreur est survenu :[",
                      isError: true);
                }
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: Text(
                  'Retour',
                   style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
