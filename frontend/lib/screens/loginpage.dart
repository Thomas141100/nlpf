import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/main.dart';
import 'package:fht_linkedin/models/user.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../module/client.dart';
import 'package:flutter/material.dart';
import '../components/signup_form.dart';
import '../module/validators.dart';

void defaultLoginHandler(
    BuildContext context, String email, String password) async {
  var response = await Client.signin(email, password);
  if (response.statusCode == 200) {
    showSnackBar(context, "User Connected");

    AutoRouter.of(context).replaceNamed('/home');
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
  final signupFirstnameController = TextEditingController();
  final signupLastNameController = TextEditingController();

  bool isLoggedIn = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    signupCompanyNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupFirstnameController.dispose();
    signupLastNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    final String? userId = await Client.getToken();

    if (userId != null) {
      MyApp.of(context).authService.authenticated = true;
      AutoRouter.of(context).replaceNamed('/home');
    }
  }

  void clearSignUpForm() {
    signupCompanyNameController.clear();
    signupEmailController.clear();
    signupFirstnameController.clear();
    signupLastNameController.clear();
    signupPasswordController.clear();
  }

  User userFromSignUpForm() {
    return User.withoutId(
        signupFirstnameController.text,
        signupLastNameController.text,
        signupEmailController.text,
        signupCompanyNameController.text.isNotEmpty,
        signupCompanyNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 36, 58, 115),
                  Color.fromARGB(255, 165, 190, 204),
                  Color.fromARGB(255, 124, 62, 102)
                ])),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/TLR-Logo.png',
                      scale: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Bonjour',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            isLoggedIn
                                ? 'Vous êtes connecté'
                                : 'Veuillez vous connecter',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  suffixIcon: Icon(Icons.mail_outline)),
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
                                  labelText: 'Mot de passe',
                                  suffixIcon: Icon(Icons.vpn_key_outlined)),
                              validator: Validators.passwordValidator(),
                            ),
                          ),
                          TextButton(
                            style: Theme.of(context).textButtonTheme.style,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      // Retrieve the text the that user has entered by using the
                                      // TextEditingController.
                                      content: Text("Dommage...",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    );
                                  });
                            },
                            child: Text('Mot de passe oublié',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: Text('Se connecter',
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  MyApp.of(context).authService.authenticated =
                                      true;
                                  widget._onLoginCallback(
                                      context,
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Vous n\'avez pas encore de compte ?',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextButton(
                                style: Theme.of(context).textButtonTheme.style,
                                child: Text('S\'inscrire',
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SignupForm(
                                            emailController:
                                                signupEmailController,
                                            passwordController:
                                                signupPasswordController,
                                            companyController:
                                                signupCompanyNameController,
                                            firstnameController:
                                                signupFirstnameController,
                                            lastnameController:
                                                signupLastNameController,
                                            formKey: _signupformKey,
                                          ),
                                          actions: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.redAccent),
                                                onPressed: () {
                                                  clearSignUpForm();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Annuler',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium)),

                                            // The "Yes" button
                                            TextButton(
                                              onPressed: () async {
                                                // Close the dialog
                                                if (_signupformKey.currentState!
                                                    .validate()) {
                                                  User newUser =
                                                      userFromSignUpForm();
                                                  var response =
                                                      await Client.signup(
                                                          newUser,
                                                          signupPasswordController
                                                              .text);
                                                  if (response.statusCode ==
                                                      200) {
                                                    clearSignUpForm();
                                                    showSnackBar(context,
                                                        "User Created");
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    showSnackBar(context,
                                                        "User creation failed",
                                                        isError: true);
                                                  }
                                                }
                                              },
                                              child: Text('S\'inscrire',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              )
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Vous recherchez du travail ? Traverser la rue !',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Il suffit juste de Traverser la rue !',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ]),
          )),
    );
  }
}
