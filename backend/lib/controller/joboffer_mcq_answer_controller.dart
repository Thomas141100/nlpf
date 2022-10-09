import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class JobOfferMCQAnswerController extends ResourceController {
  JobOfferMCQAnswerController(this.db);

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
  Future<Response> getJobOfferMCQAnswer(@Bind.path('offerId') String offerId) async {
    final user = getPayload(request!.raw.headers['authorization']![0]);
    if (user['isCompany'] == true) {
      return Response.forbidden();
    }

    final collection = db.collection("mcqs");
    final result = await collection.findOne(where.eq("offer", ObjectId.fromHexString(offerId)));
    if (result == null) {
      return Response.notFound();
    }

    final answers = result['answers'] as List;
    final answer = answers.firstWhere((element) => element['user'] == user['id'], orElse: () => null);

    if (answer == null) {
      return Response.notFound();
    }
    return Response.ok(answer);
  }

  @Operation.post('offerId')
  Future<Response> addJobOfferMCQAnswer(@Bind.path('offerId') String offerId) async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "Pas de corps 🥲"});
    }

    final user = getPayload(request!.raw.headers['authorization']![0]);
    if (user['isCompany'] == true) {
      return Response.forbidden();
    }

    final collection = db.collection("mcqs");
    final result = await collection.findOne(where.eq("offer", ObjectId.fromHexString(offerId)));
    if (result == null) {
      return Response.notFound();
    }

    final answers = result['answers'] as List;
    if (answers.any((element) => element['user'] == user['id'])) {
      return Response.badRequest(body: {"error": "Vous avez déjà répondu à ce questionnaire"});
    }

    final Map<String, dynamic> answer = await request!.body.decode();
    answer['user'] = user['id'];
    answer['creationDate'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final updated = await collection.updateOne(where.eq("offer", ObjectId.fromHexString(offerId)), modify.push("answers", answer));

    return Response.ok(answer);
  }
}
