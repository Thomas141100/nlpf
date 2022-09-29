import 'dart:convert';

import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

// parse the auth header
Future<bool> isAuthorized(Db db, String authHeader) async {
  final parts = authHeader.split(' ');
  if (parts == null || parts.length != 2 || parts[0] != 'Basic') {
    return false;
  }
  return await _isValidUsernameAndPassword(db, parts[1]);
}

// check username and password
Future<bool> _isValidUsernameAndPassword(Db db, String credentials) async {
  // this user
  final String decoded = utf8.decode(base64.decode(credentials));
  final parts = decoded.split(':');

  // check if the user exists
  var collection = db.collection("users");
  var result = await collection.findOne(where.eq("mail", parts[0]));
  
  final User user = User(parts[0], parts[1]);

  // database user
  final Database database = MockDatabase();
  final User foundUser = database.queryEmail(user.email);

  // check for match
  return foundUser != null && foundUser.password == user.password;
}

class RestrictedController extends ResourceController {
  @Operation.get()
  Future<Response> restricted(
      @Bind.header("authorization") String authHeader) async {
    // only allow with correct username and password
    if (!_isAuthorized(authHeader)) {
      return Response.forbidden();
    }

    // We are returning a string here, but this could be
    // a file or data from the database.
    return Response.ok('restricted resource');
  }
}
