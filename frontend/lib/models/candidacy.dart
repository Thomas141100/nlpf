import 'package:fht_linkedin/models/user.dart';

import 'joboffer.dart';

class UserCandidacy {
  String _id = "";
  String candidate = "";
  JobOffer offer = JobOffer();
  int creationDate = 0;
}

class JobOfferCandidacy {
  String _id = "";
  User candidate = User();
  String offer = "";
  int creationDate = 0;
}
