import 'package:flutter/material.dart';
import 'package:fht_linkedin/module/auth.dart';
import 'package:fht_linkedin/routes/route_guard.dart';
import 'package:fht_linkedin/routes/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final authService = AuthService();
  late final _appRouter = AppRouter(routeGuard: RouteGuard(authService));
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate());
  }
}
