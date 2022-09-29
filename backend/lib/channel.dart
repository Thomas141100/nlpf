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

    // Add to Db
    router.route("/users")
    .link(() => UserController(db));

    return router;
  }
}
