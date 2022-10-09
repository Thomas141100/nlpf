import 'dart:math';

import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  late var user;

  test("POST /auth/signup returns 200", () async {
    final body = {
      "mail": generateRandomString(10),
      "password": generateRandomString(10)
    };
    final response = await harness.agent?.post("/auth/signup", body: body);

    expect(response!.statusCode, 200);
    expect(
        response, hasBody(partial({"mail": body['mail'], "isCompany": false})));

    user = await response.body.decode();
    user['password'] = body['password'];
  });

  test("POST /auth/login returns 200", () async {
    final body = {"mail": user['mail'], "password": user['password']};
    final response = await harness.agent?.post("/auth/login", body: user);

    expect(response!.statusCode, 200);
    expect(response, hasBody(partial({"token": isString})));
  });

  test("POST /auth/login returns 403", () async {
    final body = {"mail": user['mail'], "password": "wrong"};
    final response = await harness.agent?.post("/auth/login", body: body);

    expect(response!.statusCode, 403);
  });

  test("DELETE /users/:id returns 200", () async {
    final response = await harness.agent?.delete(
        "/users/${user['_id'] as String}",
        headers: {"Authorization": "Bearer ${user["token"]}"});

    expect(response!.statusCode, 200);
  });
}
