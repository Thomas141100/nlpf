import 'package:backend/controller/singup.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'controller/user_controller.dart';

class Channel extends ApplicationChannel {
  Db db = Db("mongodb://root:example@localhost:27025/test?authSource=admin");

  @override
  Future prepare() async {
    await db.open();
    print("Connected to MongoDB");
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/users/[:id]").link(() => UserController(db));

    router.route('/singup').link(() => SignupController(db));

    return router;
  }
}
