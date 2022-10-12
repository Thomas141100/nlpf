import 'package:fht_linkedin/models/candidacy.dart';

import 'mcq.dart';

class JobOffer {
  String _id = "";
  String title = "";
  String employer = "";
  String companyName = "";
  List<UserCandidacy> candidacies = List.empty(growable: true);
  List<String>? tags;
  String? description;
  MCQ? mcq;

  JobOffer(this._id, this.title, this.employer, this.companyName,
      this.candidacies, this.tags, this.description, this.mcq);

  JobOffer.empty() : this("", "", "", "", [], null, null, null);

  JobOffer.fromJson(Map<dynamic, dynamic> json) {
    _id = json['_id'];
    title = json['title'];
    employer = json['employer'];
    companyName = json['companyName'];
    description = json['description'];
    tags = [json['tags']];

    if (json.containsKey('candidacies')) {
      for (var candidacy in json['candidacies']) {
        UserCandidacy temp;
        if (candidacy['offer'].runtimeType == String) {
          temp = UserCandidacy.fromJsonWithUser(candidacy);
        } else {
          temp = UserCandidacy.fromJson(candidacy);
        }
        candidacies.add(temp);
      }
    } else {
      candidacies = List.empty(growable: true);
    }
  }

  String getId() {
    return _id;
  }
}
