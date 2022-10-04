import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserController extends ResourceController {
  UserController(this.db);

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
  Future<Response> getAllUsers() async {
    final collection = db.collection("users");
    final result = await collection.find().toList();

    return Response.ok(result);
  }

  @Operation.get('id')
  Future<Response> getUserByID(@Bind.path('id') String id) async {
    final collection = db.collection("users");
    final result = await collection.findOne(where.eq("_id", id));

    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> addUser() async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    final Map<String, dynamic> user = await request!.body.decode();

    if (!user.containsKey('isCompany')) {
      user['isCompany'] = false;
    }

    final collection = db.collection("users");
    final inserted = await collection.insert(user);

    return Response.ok(inserted);
  }

  @Operation.put('id')
  Future<Response> updateUser(@Bind.path('id') String id) async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    final collection = db.collection("users");
    final Map<String, dynamic> user = await request!.body.decode();
    final updated = await collection.update(where.eq("_id", id), user);

    return Response.ok(updated);
  }

  @Operation.delete('id')
  Future<Response> deleteUser(@Bind.path('id') String id) async {
    final collection = db.collection("users");
    final deleted = await collection.remove(where.eq("_id", id));

    return Response.ok(deleted);
  }
}
