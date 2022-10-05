import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/login.dart';
import 'package:fht_linkedin/routes/route_guard.dart';
import 'package:fht_linkedin/user.dart';

import '../homepage.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, name: 'LoginRoute', path: '/'),
    AutoRoute(
        page: HomePage,
        name: 'HomeRoute',
        path: '/home',
        guards: [RouteGuard],
        initial: true),
    AutoRoute(
        page: UserPage, name: 'UserRoute', path: '/user', guards: [RouteGuard])
  ],
)
class $AppRouter {}
