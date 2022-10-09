import 'package:fht_linkedin/models/user.dart';

import 'job_offer.dart';

class UserCandidacy {
  String _id = "";
  String candidate = "";
  JobOffer offer = JobOffer.empty();
  int creationDate = 0;
}

class JobOfferCandidacy {
  String _id = "";
  User candidate = User.empty();
  String offer = "";
  int creationDate = 0;
}
