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
  final result = await collection.findOne(where.eq("mail", user['mail']));
  if (result != null) {
    return Response.forbidden();
  }

  // sanitize input
  user['creationDate'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  if (!user.containsKey('isCompany')) {
    user['isCompany'] = false;
  }

  // add user to database
  await collection.insertOne(user);
  final inserted = await collection.findOne(where.eq("mail", user['mail']));

  if (inserted == null) {
    return Response.serverError();
  }

  final String token = generateToken(inserted);

  inserted.remove('password');
  inserted['token'] = token;

  // send a response
  return Response.ok(inserted);
}

String generateToken(Map<String, dynamic> user) {
  final jwt = JWT({
    'id': user['_id'],
    'mail': user['mail'],
    'isCompany': user['isCompany'],
    'exp': DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch
  });

  return jwt.sign(SecretKey(config.jwtSecret));
}

Future<Response> login(Request request, Db db) async {
  // get user info from request body
  final Map<String, dynamic> user = await request.body.decode();

  // check if the user exists
  final collection = db.collection("users");
  final result = await collection.findOne(where.eq("mail", user['mail']));
  if (result == null) {
    return Response.forbidden();
  }

  if (result['password'] != user['password']) {
    return Response.forbidden();
  }

  final String token = generateToken(result);

  // send a response
  return Response.ok({'token': token});
}
