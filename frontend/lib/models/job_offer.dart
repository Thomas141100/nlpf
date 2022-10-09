import 'mcq.dart';

class JobOffer {
  String _id = "";
  String title = "";
  String employer = "";
  String companyName = "";
  List<String>? candidacies;
  List<String>? tags;
  String? description;
  MCQ? mcq;

  JobOffer(this._id, this.title, this.employer, this.companyName,
      this.candidacies, this.tags, this.description, this.mcq);

  JobOffer.empty() : this("", "", "", "", null, null, null, null);

  String getId() {
    return _id;
  }
}
