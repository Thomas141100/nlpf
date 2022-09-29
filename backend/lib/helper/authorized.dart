import 'dart:convert';

import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

// parse the auth header
Future<bool> isAuthorized(Db db, String authHeader) async {
  final parts = authHeader.split(' ');
  if (parts == null || parts.length != 2 || parts[0] != 'Basic') {
    return false;
  }
  return await isValidUsernameAndPassword(db, parts[1]);
}

// check username and password
Future<bool> isValidUsernameAndPassword(Db db, String credentials) async {
  // this user
  final String decoded = utf8.decode(base64.decode(credentials));
  final parts = decoded.split(':');

  // check if the user exists
  var collection = db.collection("users");
  var result = await collection.findOne(where.eq("mail", parts[0]));

  return result != null && result['password'] == parts[1];
}
