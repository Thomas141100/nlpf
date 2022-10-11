import 'package:flutter/material.dart';
import 'package:fht_linkedin/module/auth.dart';
import 'package:fht_linkedin/routes/auth_guard.dart';
import 'package:fht_linkedin/routes/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final authService = AuthService();
  late final _appRouter = AppRouter(authGuard: AuthGuard(authService));
  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: ".env");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate());
  }
}
