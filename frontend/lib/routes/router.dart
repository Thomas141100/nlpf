import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/login.dart';
import 'package:fht_linkedin/routes/route_guard.dart';

import '../homepage.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, name: 'LoginRoute', path: '/', initial: true),
    AutoRoute(
      page: HomePage,
      name: 'HomeRoute',
      path: '/home',
      guards: [RouteGuard],
    )
  ],
)
class $AppRouter {}
