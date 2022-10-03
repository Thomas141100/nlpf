import 'dart:ffi';

import 'package:conduit/conduit.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../configuration.dart';

final config = ApplicationConfiguration("config.yaml");

Future<Response> signup(Request request, Db db) async {
  // get user info from request body
  final Map<String, dynamic> user = await request.body.decode();

  // check if the user exists
  final collection = db.collection("users");
  final result = await collection
      .findOne(where.eq("mail", user['mail']).excludeFields(['password']));
  if (result != null) {
    return Response.forbidden();
  }

  // add user to database
  await collection.insertOne(user);

  // send a response
  return Response.ok('User added');
}

String generateToken(String mail, String password, bool isCompany) {
  final jwt = JWT({
    'mail': mail,
    'isCompany': isCompany,
    'exp': DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch
  });

  return jwt.sign(SecretKey(config.jwtSecret));
}

Future<Response> login(Request request, Db db) async {
  // get user info from request body
  final Map<String, dynamic> user = await request.body.decode();

  // check if the user exists
  final collection = db.collection("users");
  var result = await collection.findOne(where.eq("mail", user['mail']));
  if (result == null) {
    return Response.forbidden();
  }

  if (result['password'] != user['password']) {
    return Response.forbidden();
  }

  print(result);

  String token = generateToken(result['mail'] as String,
      result['password'] as String, result['isCompany'] as bool);

  // send a response
  return Response.ok({'token': token});
}
