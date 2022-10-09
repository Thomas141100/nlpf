import 'dart:math';
import 'package:backend/backend.dart';
import 'package:conduit_test/conduit_test.dart';

export 'package:backend/backend.dart';
export 'package:conduit_test/conduit_test.dart';
export 'package:test/test.dart';

/// A testing harness for backend.
///
/// A harness for testing an conduit application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

class Harness extends TestHarness<BackendChannel> {
  @override
  Future onSetUp() async {}

  Future tearDownAll() async {
    await channel?.db.drop();
  }
}
