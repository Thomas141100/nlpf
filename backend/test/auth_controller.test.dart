import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  late var user;

  test("POST /auth/signup returns 200", () async {
    final body = {"mail": "mail", "password": "foobar"};
    final response = await harness.agent?.post("/auth/signup", body: body);

    expect(response!.statusCode, 200);
    expect(response, hasBody(partial({
      "mail": "mail",
      "isCompany": false
    })));

    user = await response.body.decode();
  });

  test("POST /auth/login returns 200", () async {
    final body = {"mail": "mail", "password": "foobar"};
    final response = await harness.agent?.post("/auth/login", body: body);

    expect(response!.statusCode, 200);
    expect(response, hasBody(partial({
      "token": isString
    })));
  });

  test("POST /auth/login returns 403", () async {
    final body = {"mail": "mail", "password": "wrong"};
    final response = await harness.agent?.post("/auth/login", body: body);

    expect(response!.statusCode, 403);
  });

  test("DELETE /users/:id returns 200", () async {
    final response = await harness.agent?.delete("/users/${user['_id'] as String}", headers: {
      "Authorization": "Bearer ${user["token"]}"
    });

    expect(response!.statusCode, 200);
  });
}
