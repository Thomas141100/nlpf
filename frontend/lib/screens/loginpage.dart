import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/main.dart';
import 'package:fht_linkedin/routes/router.gr.dart';
import 'package:fht_linkedin/utils/utils.dart';

import '../module/client.dart';
import 'package:flutter/material.dart';
import '../components/signup_form.dart';
import '../components/header.dart';
import '../module/validators.dart';

void defaultLoginHandler(
    BuildContext context, String email, String password) async {
  var response = await Client.signin(email, password);
  if (response.statusCode == 200) {
    showSnackBar(context, "User Connected");

    AutoRouter.of(context).push(const HomeRoute());
  }
}

class LoginPage extends StatefulWidget {
  final Function(BuildContext context, String email, String password)
      _onLoginCallback;
  const LoginPage({super.key}) : _onLoginCallback = defaultLoginHandler;
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
                validator: Validators.emailValidator(),
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
                validator: Validators.passwordValidator(),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    MyApp.of(context).authService.authenticated = true;
                    widget._onLoginCallback(
                        context, emailController.text, passwordController.text);
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
                                    var response = await Client.signup(
                                        signupEmailController.text,
                                        signupPasswordController.text,
                                        signupCompanyNameController.text);
                                    if (response.statusCode == 200) {
                                      showSnackBar(context, "User Created");
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              // Retrieve the text the that user has entered by using the
                                              // TextEditingController.
                                              content: Text(
                                                  "Account Creation Failed"),
                                            );
                                          });
                                    }
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