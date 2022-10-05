import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class JobOfferController extends ResourceController {
  JobOfferController(this.db);

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

  @Operation.get()
  Future<Response> getAllJobOffers() async {
    final collection = db.collection("joboffers");
    final result = await collection.find().toList();

    return Response.ok(result);
  }

  @Operation.get('id')
  Future<Response> getJobOfferByID(@Bind.path('id') String id) async {
    final objectId = ObjectId.fromHexString(id);

    final collection = db.collection("joboffers");
    final result = await collection.findOne(where.eq("_id", objectId));

    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> addJobOffer() async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    final Map<String, dynamic> jobOffer = await request!.body.decode();
    if (!jobOffer.containsKey('employer')) {
      var user =
          getPayloadFromHeader(request!.raw.headers['authorization']![0]);
      jobOffer['employer'] = user['id'];
    }

    final collection = db.collection("joboffers");
    final inserted = await collection.insertOne(jobOffer);

    print(inserted.document);
    return Response.ok(inserted.document);
  }

  @Operation.put('id')
  Future<Response> updateUser(@Bind.path('id') String id) async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    final objectId = ObjectId.fromHexString(id);
    final Map<String, dynamic> jobOffer = await request!.body.decode();

    final collection = db.collection("joboffers");
    final updated = await collection.updateOne(where.eq("_id", objectId), jobOffer);

    return Response.ok(updated.document);
  }

  @Operation.delete('id')
  Future<Response> deleteUser(@Bind.path('id') String id) async {
    final objectId = ObjectId.fromHexString(id);

    final collection = db.collection("joboffers");
    final deleted = await collection.deleteOne(where.eq("_id", objectId));

    return Response.ok(deleted.document);
  }
}
