import 'package:flutter/material.dart';
import 'package:fht_linkedin/module/auth.dart';
import 'package:fht_linkedin/routes/auth_guard.dart';
import 'package:fht_linkedin/routes/router.gr.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 124, 62, 102),
          secondaryHeaderColor: const Color.fromARGB(255, 36, 58, 115),
          backgroundColor: const Color.fromARGB(255, 242, 235, 233),
          fontFamily: 'Baskervville', //GoogleFonts.baskervville(),
          textTheme: TextTheme(
            displayLarge: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 35,
                          color: const Color.fromARGB(255, 36, 58, 115)),
            displayMedium: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: const Color.fromARGB(255, 36, 58, 115)),
          titleLarge: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 35,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
          titleMedium: TextStyle(
                          fontSize: 20.0,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
          titleSmall: TextStyle(
                          fontSize: 15.0,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),

          bodyLarge: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
          bodyMedium: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
                        
          bodySmall: TextStyle(
                          fontSize: 10,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
          labelLarge: TextStyle(
                          fontSize: 20.0,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
          labelMedium: TextStyle(
                          fontSize: 15.0,
                          color: const Color.fromARGB(255, 36, 58, 115),
                        ),
                        labelSmall:  TextStyle(
                          fontSize: 15,
                          color: Colors.white)

              
              ),
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate());
  }
}
