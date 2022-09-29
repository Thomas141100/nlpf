import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:backend/helpers/user.dart';
import 'package:backend/helpers/database.dart';

class SignupController extends ResourceController {
  SignupController(this.db);

  final Db db;

  @Operation.post()
  Future<Response> signup() async {
    // get user info from request body
    Map<String, dynamic> user = await request!.body.decode();

    // check if the user exists
    var collection = db.collection("users");
    var result = await collection.findOne(where.eq("mail", user['mail']));
    if (result != null) {
      return Response.forbidden();
    }

    // add user to database
    await collection.insertOne(user);

    // send a response
    return Response.ok('User added');
  }
}
