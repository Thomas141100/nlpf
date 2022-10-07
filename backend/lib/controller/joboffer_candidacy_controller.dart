import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class JobOfferCandidacyController extends ResourceController {
  JobOfferCandidacyController(this.db);

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

  @Operation.get('offerId')
  Future<Response> getAllCandidacies(@Bind.path('offerId') String offerId) async {
    var query = where.eq("offer", ObjectId.fromHexString(offerId));

    final candidacyCollection = db.collection("candidacies");
    final result = await candidacyCollection.find(query).toList();

    for (final candidacy in result) {
      final userCollection = db.collection("users");
      final user = await userCollection.findOne(where
          .excludeFields(["password", "candidacies"])
          .eq("_id", candidacy["candidate"]));
      candidacy["candidate"] = user;
    }

    return Response.ok(result);
  }

  @Operation.post('offerId')
  Future<Response> addCandidacy(@Bind.path('offerId') String offerId) async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    final user = getPayload(request!.raw.headers['authorization']![0]);
    if (user['isCompany'] == true) {
      return Response.forbidden();
    }

    final Map<String, dynamic> candidate = await request!.body.decode();
    candidate['creationDate'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (!candidate.containsKey('candidate')) {
      candidate['candidate'] = ObjectId.fromHexString(user['id'] as String);
    }
    if (!candidate.containsKey('offer')) {
      candidate['offer'] = ObjectId.fromHexString(offerId);
    }

    final candidacyCollection = db.collection("candidacies");
    final inserted = await candidacyCollection.insertOne(candidate);

    final jobOfferCollection = db.collection("joboffers");
    final jobOfferResult = await jobOfferCollection.updateOne(
        where.eq("_id", ObjectId.fromHexString(offerId)),
        modify.addToSet("candidacies", inserted.document!['_id']));

    final userCollection = db.collection("users");
    final userResult = await userCollection.updateOne(
        where.eq("_id", ObjectId.fromHexString(user['id'] as String)),
        modify.addToSet("candidacies", inserted.document!['_id']));

    return Response.ok(inserted.document);
  }
}
