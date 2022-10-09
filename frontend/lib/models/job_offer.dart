class JobOffer {
  String _id = "";
  String title = "";
  String employer = "";
  String companyName = "";
  List<String>? candidacies;
  List<String>? tags;
  String? description;

  JobOffer(this._id, this.title, this.employer, this.companyName,
      this.candidacies, this.tags, this.description);

  JobOffer.empty() : this("", "", "", "", null, null, null);

  String getId() {
    return _id;
  }
}
