import 'package:fht_linkedin/models/job_offer.dart';
import 'package:fht_linkedin/models/user.dart';

class UserCandidacy {
  String _id = "";
  String candidateId = "";
  JobOffer? offer;
  int creationDate = 0;

  UserCandidacy(this._id, this.candidateId, this.offer, this.creationDate);
  UserCandidacy.empty() : this("", "", JobOffer.empty(), 0);

  UserCandidacy.fromJson(Map<dynamic, dynamic> json)
      : _id = json['_id'],
        candidateId = json['candidate'],
        creationDate = json['creationDate'],
        offer = json['offer'] != null ? JobOffer.fromJson(json['offer']) : null;

  UserCandidacy.fromJsonWithUser(Map<dynamic, dynamic> json)
      : _id = json['_id'],
        candidateId = json['candidate'],
        creationDate = json['creationDate'];
}

class JobOfferCandidacy {
  String _id = "";
  User candidate = User.empty();
  String offerId = "";
  int creationDate = 0;
  int score = 0;

  String getId() => _id;

  JobOfferCandidacy(
      this._id, this.candidate, this.offerId, this.creationDate, this.score);

  JobOfferCandidacy.empty() : this("", User.empty(), "", 0, 0);

  JobOfferCandidacy.fromJson(Map<dynamic, dynamic> json) {
    _id = json['_id'];
    candidate = User.fromJson(json['candidate']);
    offerId = json['offer'];
    creationDate = json['creationDate'];
    score = json['score'] != null ? int.parse(json['score']) : 0;
  }
}
