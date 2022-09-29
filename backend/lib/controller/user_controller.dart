import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../model/user.dart';

class UserController extends ResourceController {
  UserController(this.db);

  final Db db;

  @Operation.get()
  Future<Response> getAllUsers() async {
    var collection = db.collection("users");
    var result = await collection.find().toList();

    return Response.ok(result);
  }

  @Operation.get('id')
  Future<Response> getUserByID(@Bind.path('id') int id) async {
    var collection = db.collection("users");
    var result = await collection.findOne(where.eq("id", id));

    

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



  // @override
  // Controller get entryPoint {
  //   final router = Router();

  //   // Add to Db
  //   router.route("/mongo/add").linkFunction((request) async {
  //     var collection = db.collection("test");
  //     await collection.insert({"name": "Dart"});
  //     return Response.ok({"key": "value"});
  //   });

    

  //   // Update in Db
  //   router.route("/mongo/update").linkFunction((request) async {
  //     var collection = db.collection("test");
  //     await collection.update({"name": "Dart"}, {"name": "Dart2"});
  //     return Response.ok({"key": "value"});
  //   });

  //   // Delete from Db
  //   router.route("/mongo/delete").linkFunction((request) async {
  //     var collection = db.collection("test");
  //     await collection.remove({"name": "Dart2"});
  //     return Response.ok({"key": "value"});
  //   });

  //   return router;
  // }
}
