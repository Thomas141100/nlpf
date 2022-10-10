import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/main.dart';
import 'package:fht_linkedin/models/user.dart';
import 'package:fht_linkedin/routes/router.gr.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final signupFirstnameController = TextEditingController();
  final signupLastNameController = TextEditingController();

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
                    child:
                    Image.asset(
                          'images/TLR-Logo.png',
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Bonjour',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Veuillez vous connecter',
                            style: TextStyle(fontSize: 20),
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
                                  labelText: 'email',
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
                                  labelText: 'Password',
                                  suffixIcon: Icon(Icons.vpn_key_outlined)),
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
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Sign in'),
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
                                              child: Text('Cancel', 
                                              style: GoogleFonts.allan(),)
                                            ),

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
                                              child:  Text('Sign up', 
                                              style: GoogleFonts.allan(),),
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
                const Text(
                      'Vous recherchez du travail ? Traverser la rue !',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500,
                          fontSize: 35),
                    ),
                    SizedBox(
                  height: 20,
                ),
                const Text(
                      'Il suffit juste de Traverser la rue !',
                      style:TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          
                          fontSize: 35),
                    ),
                ]),
          )),
          
    );
  }
}
