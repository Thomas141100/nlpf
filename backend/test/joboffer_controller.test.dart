import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  late Map<String, dynamic> user;
  late Map<String, dynamic> jobOffer;

  test("POST /auth/signup isCompany returns 200", () async {
    final body = {
      "mail": generateRandomString(10),
      "password": generateRandomString(10),
      "isCompany": true
    };
    final response = await harness.agent?.post("/auth/signup", body: body);

    expect(response!.statusCode, 200);
    expect(
        response, hasBody(partial({"mail": body['mail'], "isCompany": true})));

    user = await response.body.decode();
  });

  test("POST /joboffers returns 200", () async {
    final body = {
      "title": "tomate",
      "companyName": "rouge",
      "tags": ["je", "suis", "une"]
    };
    final response = await harness.agent?.post("/joboffers",
        headers: {"Authorization": "Bearer ${user["token"]}"}, body: body);

    expect(response!.statusCode, 200);
    expect(response, hasBody(partial(body)));

    jobOffer = await response.body.decode();
  });

  test("GET /joboffers/:id returns 200", () async {
    final response = await harness.agent?.get(
        "/joboffers/${jobOffer['_id'] as String}",
        headers: {"Authorization": "Bearer ${user["token"]}"});

    expect(response!.statusCode, 200);
    expect(response, hasBody(partial(jobOffer)));
  });

  test("DELETE /joboffers/:id returns 200", () async {
    final response = await harness.agent?.delete(
        "/joboffers/${jobOffer['_id'] as String}",
        headers: {"Authorization": "Bearer ${user["token"]}"});

    expect(response!.statusCode, 200);
  });
}
