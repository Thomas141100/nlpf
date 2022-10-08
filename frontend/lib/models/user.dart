class User {
  String _id;
  String email;
  String firstname;
  String lastname;
  bool isCompany;
  String? companyName;
  List<String>? jobOffers;

  User(this._id, this.firstname, this.lastname, this.email, this.isCompany,
      this.companyName);

  User.empty() : this("", "", "", "", false, "");

  User.withoutId(firstname, lastname, email, isCompany, companyName)
      : this("", firstname, lastname, email, isCompany, companyName);

  bool isEmptyUser() {
    return firstname == "" && lastname == "" && email == "";
  }

  @override
  String toString() {
    return '$firstname $lastname has email $email';
  }

  String get id => _id;
}
