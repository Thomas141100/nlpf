import 'package:fht_linkedin/models/user.dart';

import 'job_offer.dart';

class UserCandidacy {
  String _id = "";
  String candidate = "";
  JobOffer offer = JobOffer.empty();
  int creationDate = 0;

  UserCandidacy(this._id, this.candidate, this.offer, this.creationDate);
}

class JobOfferCandidacy {
  String _id = "";
  User candidate = User.empty();
  String offer = "";
  int creationDate = 0;

  String getId() => _id;
}
