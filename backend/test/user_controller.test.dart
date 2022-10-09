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
    expect(response, hasBody(partial({"mail": body['mail'], "isCompany": false})));

    user = await response.body.decode();
  });

  test("GET /users/:id returns 200", () async {
    final response = await harness.agent?.get("/users/${user['_id'] as String}",
        headers: {"Authorization": "Bearer ${user["token"]}"});

    expect(response!.statusCode, 200);
    expect(
        response,
        hasBody(partial({
          "_id": user["_id"],
          "mail": user["mail"],
          "isCompany": user["isCompany"]
        })));
  });

  test("DELETE /users/:id returns 200", () async {
    final response = await harness.agent?.delete(
        "/users/${user['_id'] as String}",
        headers: {"Authorization": "Bearer ${user["token"]}"});

    expect(response!.statusCode, 200);
  });
}
