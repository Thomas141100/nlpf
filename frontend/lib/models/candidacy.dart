import 'package:fht_linkedin/models/job_offer.dart';
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
  // String candidate = "";
  String offer = "";
  int creationDate = 0;
  int score = 0;

  String getId() => _id;

  JobOfferCandidacy(
      this._id, this.candidate, this.offer, this.creationDate, this.score);

  JobOfferCandidacy.empty() : this("", User.empty(), "", 0, 0);

  JobOfferCandidacy.fromJson(Map<dynamic, dynamic> json) {
    _id = json['_id'];
    candidate = User.fromJson(json['candidate']);
    offer = json['offer'];
    creationDate = json['creationDate'];
    score = json['score'] != null ? int.parse(json['score']) : 0;
  }
  // JobOfferCandidacy.fromJson(Map<String, dynamic> json)
  //     : _id = json['_id'],
  //       candidate = json['candidate'],
  //       creationDate = json['creationDate'],
  //       offer = json['offer'] != null
  //           ? JobOffer.fromJson(json['offer'])
  //           : JobOffer.empty();
}
