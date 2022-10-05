import 'package:fht_linkedin/user.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(title: "Login"),
        '/home': (context) => const HomePage(title: 'Home'),
        '/user': (context) => const UserPage(title: "User")
      },
    );
  }
}
