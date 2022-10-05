import 'package:backend/configuration.dart';
import 'package:conduit/conduit.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'controller/auth_controller.dart';
import 'controller/joboffer_controller.dart';
import 'controller/user_controller.dart';

class Channel extends ApplicationChannel {
  late Db db;

  @override
  Future prepare() async {
    final config = ApplicationConfiguration("config.yaml");
    db = Db(config.mongoUri);
    await db.open();
    print("Connected to MongoDB");
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/auth/signup").linkFunction((request) => signup(request, db));
    router.route("/auth/login").linkFunction((request) => login(request, db));

    router.route("/users/[:id]").link(() => UserController(db));
    router.route("/joboffers/[:id]").link(() => JobOfferController(db));

    return router;
  }
}
