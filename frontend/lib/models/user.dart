class User {
  String _id;
  String email;
  String firstname;
  String lastname;
  bool isCompany;
  String? companyName;
  List<String>? jobOffers;
  int? score;

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
    return '$firstname $lastname ${isCompany ? 'is a company and ' : ''}has email $email and id $_id.';
  }

  String get id => _id;

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'mail': email,
        'isCompany': isCompany,
        'companyName': companyName,
        'jobOffers': jobOffers
      };

  User.fromJson(Map<dynamic, dynamic> json)
      : _id = json['_id'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        email = json['mail'],
        isCompany = json['isCompany'] == "true",
        companyName = json['isCompany'] == "true" ? json['companyName'] : "",
        score = json['score'] != null ? int.parse(json['score']) : 0;
}
