import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/screens/loginpage.dart';
import 'package:fht_linkedin/routes/auth_guard.dart';
import 'package:fht_linkedin/screens/userpage.dart';

import '../screens/homepage.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, name: 'LoginRoute', path: '/'),
    AutoRoute(
        page: HomePage,
        name: 'HomeRoute',
        path: '/home',
        guards: [AuthGuard],
        initial: true),
    AutoRoute(
        page: UserPage, name: 'UserRoute', path: '/user', guards: [AuthGuard])
  ],
)
class $AppRouter {}
