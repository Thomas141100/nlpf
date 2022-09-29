import 'dart:async';

import 'package:backend/helper/authorized.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserController extends ResourceController {
  UserController(this.db);

  final Db db;

  @override
  FutureOr<RequestOrResponse> willProcessRequest(Request res) async {
    // check if the user is authorized
    if (!await isAuthorized(db, request!.raw.headers['authorization']![0])) {
      return Response.forbidden();
    }
    return res;
  }

  @Operation.get()
  Future<Response> getAllUsers(@Bind.header("authorization") String authHeader) async {
    if (!await isAuthorized(db, authHeader))
      return Response.forbidden();

    var collection = db.collection("users");
    var result = await collection.find().toList();

    return Response.ok(result);
  }

  @Operation.get('id')
  Future<Response> getUserByID(@Bind.path('id') ObjectId id) async {
    var collection = db.collection("users");
    var result = await collection.findOne(where.eq("_id", id));

    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> addUser() async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    var collection = db.collection("users");
    Map<String, dynamic> user = await request!.body.decode();
    var inserted = await collection.insert(user);

    return Response.ok(inserted);
  }

  @Operation.put('id')
  Future<Response> updateUser(@Bind.path('id') ObjectId id) async {
    if (request?.body == null || request!.body.isEmpty) {
      return Response.badRequest(body: {"error": "No body"});
    }

    var collection = db.collection("users");
    Map<String, dynamic> user = await request!.body.decode();
    var updated = await collection.update(where.eq("_id", id), user);

    return Response.ok(updated);
  }

  @Operation.delete('id')
  Future<Response> deleteUser(@Bind.path('id') ObjectId id) async {
    var collection = db.collection("users");
    var deleted = await collection.remove(where.eq("_id", id));

    return Response.ok(deleted);
  }
}
