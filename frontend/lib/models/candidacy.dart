import 'package:fht_linkedin/models/user.dart';

class UserCandidacy {
  String _id = "";
  String candidate = "";
  String offerId = "";
  int creationDate = 0;

  UserCandidacy(this._id, this.candidate, this.offerId, this.creationDate);
  UserCandidacy.empty() : this("", "", "", 0);

  UserCandidacy.fromJson(Map<dynamic, dynamic> json)
      : _id = json['_id'],
        candidate = json['candidate'],
        creationDate = json['creationDate'],
        offerId = json['offer'];
}

class JobOfferCandidacy {
  String _id = "";
  User candidate = User.empty();
  String offer = "";
  int creationDate = 0;

  String getId() => _id;

  JobOfferCandidacy.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        candidate = json['candidate'],
        creationDate = json['creationDate'],
        offer = json['offer'];
}
