import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class JobOfferMCQController extends ResourceController {
  JobOfferMCQController(this.db);

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
  Future<Response> getJobOfferMCQ(@Bind.path('offerId') String offerId) async {
    final mcqCollection = db.collection("mcqs");
    final result = await mcqCollection.findOne(where.eq("offer", ObjectId.fromHexString(offerId)));

     if (result == null) {
      return Response.notFound();
    }
    return Response.ok(result);
  }

  @Operation.post('offerId')
  Future<Response> addJobOfferMCQ(@Bind.path('offerId') String offerId) async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "Pas de corps 🥲"});
    }

    final user = getPayload(request!.raw.headers['authorization']![0]);
    if (user['isCompany'] == true) {
      return Response.forbidden();
    }

    final Map<String, dynamic> mcq = await request!.body.decode();
    mcq['creationDate'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    mcq['answers'] = [];

    if (!mcq.containsKey('offer')) {
      mcq['offer'] = ObjectId.fromHexString(offerId);
    }

    final mcqCollection = db.collection("mcqs");
    final inserted = await mcqCollection.insertOne(mcq);

    return Response.ok(inserted.document);
  }
}
