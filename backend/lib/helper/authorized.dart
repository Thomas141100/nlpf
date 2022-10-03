import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../configuration.dart';

final config = ApplicationConfiguration("config.yaml");

// parse the auth header
Future<bool> isAuthorized(Db db, String authHeader) async {
  final parts = authHeader.split(' ');
  if (parts.length != 2 || parts[0] != 'Bearer') {
    return false;
  }
  return await isValidUsernameAndPassword(db, parts[1]);
}

// check username and password
Future<bool> isValidUsernameAndPassword(Db db, String token) async {
  try {
    // Verify a token
    final jwt = JWT.verify(token, SecretKey(config.jwtSecret));
    return true;
  } on JWTExpiredError {
    return false;
  } catch (ex) {
    return false;
  }
}
