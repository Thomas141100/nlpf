import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserCandidacyController extends ResourceController {
  UserCandidacyController(this.db);

  final Db db;

  @override
  FutureOr<RequestOrResponse> willProcessRequest(Request req) async {
    if (req.raw.headers['authorization']?[0] == null)
      return Response.unauthorized();

    // check if the user is authorized
    if (!await isAuthorized(db, req.raw.headers['authorization']![0]))
      return Response.forbidden();

    return req;
  }

  @Operation.get('userId')
  Future<Response> getAllCandidacies(@Bind.path('userId') String userId) async {
    final candidacyCollection = db.collection("candidacies");
    final result = await candidacyCollection
        .find(where.eq("candidate", ObjectId.fromHexString(userId)))
        .toList();

    for (final candidacy in result) {
      final offerCollection = db.collection("joboffers");
      final offer = await offerCollection.findOne(where
          .excludeFields(["candidacies"])
          .eq("_id", candidacy["offer"]));
      candidacy["offer"] = offer;
    }

    return Response.ok(result);
  }
}
