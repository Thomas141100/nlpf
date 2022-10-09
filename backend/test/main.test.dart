import 'harness/app.dart';

import 'auth_controller.test.dart' as auth_controller;
import 'user_controller.test.dart' as user_controller;

Future main() async {
  await auth_controller.main();
  await user_controller.main();
}
