import 'package:fht_linkedin/module/client.dart';
import 'package:flutter/material.dart';
import 'package:fht_linkedin/module/auth.dart';
import 'package:fht_linkedin/routes/auth_guard.dart';
import 'package:fht_linkedin/routes/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadEnv();
    Client();
  }

  void _loadEnv() {
    dotenv.load(fileName: "assets/env.conf").then((value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("apiUrl", dotenv.env['API_URL']!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 124, 62, 102),
          secondaryHeaderColor: const Color.fromARGB(255, 36, 58, 115),
          backgroundColor: const Color.fromARGB(255, 242, 235, 233),
          hoverColor: Color.fromARGB(255,165, 190, 204),
          fontFamily: 'Baskervville', //GoogleFonts.baskervville(),
          dialogBackgroundColor: const Color.fromARGB(255, 242, 235, 233) ,
          shadowColor:  Theme.of(context).primaryColor,
          highlightColor: const Color.fromARGB(255, 124, 62, 102),
          cardColor: const Color.fromARGB(255, 242, 235, 233),
          //cardTheme: ,
          textButtonTheme: TextButtonThemeData(style: Theme.of(context).elevatedButtonTheme.style),
          buttonTheme: ButtonThemeData(
            hoverColor: const Color.fromARGB(255, 36, 58, 115),
            buttonColor: const Color.fromARGB(255, 124, 62, 102),
          ),
          iconTheme: IconThemeData(color:const Color.fromARGB(255, 242, 235, 233) ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            foregroundColor:Theme.of(context).hoverColor,
            backgroundColor: const Color.fromARGB(255, 124, 62, 102),
            shadowColor: const Color.fromARGB(255, 36, 58, 115),
            textStyle:  TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color:Color.fromARGB(255, 242, 235, 233)) 
          )),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              hoverColor: const Color.fromARGB(255, 36, 58, 115),
              backgroundColor: const Color.fromARGB(255, 124, 62, 102)),
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                  color: Color.fromARGB(255, 36, 58, 115)),
              displayMedium: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Color.fromARGB(255, 36, 58, 115)),
              displaySmall:  TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color:Color.fromARGB(255, 242, 235, 233)),
              headlineLarge: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: const Color.fromARGB(255, 242, 235, 233)),
              headlineMedium: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color.fromARGB(255, 36, 58, 115)),
              headlineSmall: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color:Color.fromARGB(255, 242, 235, 233)) ,
              titleLarge: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 35,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              titleMedium: TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              titleSmall: TextStyle(
                fontSize: 15.0,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              bodyLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              bodyMedium: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              bodySmall: TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              labelLarge: TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              labelMedium: TextStyle(
                fontSize: 15.0,
                color: Color.fromARGB(255, 36, 58, 115),
              ),
              labelSmall: TextStyle(fontSize: 15, color: Colors.white)),
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate());
  }
}
