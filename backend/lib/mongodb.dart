import 'package:backend/backend.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBChannel extends ApplicationChannel {
  Db db = Db("mongodb://root:example@localhost:27025/test?authSource=admin");

  @override
  Future prepare() async {
    print("Opening MongoDB connection");
    print(db.uriList);
    await db.open();
    print("Opened MongoDB connection");
  }

  @override
  Controller get entryPoint {
    final router = Router();

    // Add to Db
    router.route("/mongo/add").linkFunction((request) async {
      var collection = db.collection("test");
      await collection.insert({"name": "Dart"});
      return Response.ok({"key": "value"});
    });

    // Get from Db
    router.route("/mongo/get").linkFunction((request) async {
      var collection = db.collection("test");
      var result = await collection.find().toList();
      return Response.ok(result);
    });

    // Update in Db
    router.route("/mongo/update").linkFunction((request) async {
      var collection = db.collection("test");
      await collection.update({"name": "Dart"}, {"name": "Dart2"});
      return Response.ok({"key": "value"});
    });

    // Delete from Db
    router.route("/mongo/delete").linkFunction((request) async {
      var collection = db.collection("test");
      await collection.remove({"name": "Dart2"});
      return Response.ok({"key": "value"});
    });

    return router;
  }
}
