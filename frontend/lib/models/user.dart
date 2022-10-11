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

  String getId() => _id;

  void setId(String id) => _id = id;

  @override
  String toString() {
    return '$firstname $lastname has email $email and id $_id';
  }

  String get id => _id;

  Map<String, dynamic> toJson() => {
        'id': _id,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'isCompany': isCompany,
        'companyName': companyName,
        'jobOffers': jobOffers
      };
}
