import 'dart:developer';
import 'module/client.dart';
import 'package:flutter/material.dart';
import 'components/signup_form.dart';
import 'homepage.dart';
import 'components/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _signupformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupCompanyNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    signupCompanyNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        displayLogout: false,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'FHT Production',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        // Retrieve the text the that user has entered by using the
                        // TextEditingController.
                        content: Text("Get Fucked for now"),
                      );
                    });
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Sign in'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomePage(
                          title: "Post Feed",
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SignupForm(
                                emailController: signupEmailController,
                                passwordController: signupPasswordController,
                                companyController: signupCompanyNameController,
                                formKey: _signupformKey),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.redAccent),
                                onPressed: () {
                                  signupEmailController.clear();
                                  signupPasswordController.clear();
                                  signupCompanyNameController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),

                              // The "Yes" button
                              TextButton(
                                onPressed: () async {
                                  // Close the dialog
                                  if (_signupformKey.currentState!.validate()) {
                                    Navigator.of(context).pop();
                                    Client.signup(
                                        signupEmailController.text,
                                        signupPasswordController.text,
                                        signupCompanyNameController.text);
                                  }
                                  signupEmailController.clear();
                                  signupPasswordController.clear();
                                  signupCompanyNameController.clear();
                                },
                                child: const Text('Sign up'),
                              ),
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
