import 'package:fht_linkedin/module/validators.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var companyController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SignupForm(
      {required this.firstnameController,
      required this.lastnameController,
      required this.emailController,
      required this.passwordController,
      required this.companyController,
      required this.formKey,
      super.key = const ValueKey("signup_form")});

  @override
  State<SignupForm> createState() => _SignupForm();
}

class _SignupForm extends State<SignupForm> {
  final passwordConfirmController = TextEditingController();
  bool isCompany = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child:  Text(
                'Sign up',
                 style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: widget.firstnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Firstname',
                ),
                validator: Validators.firstnamelValidator(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: widget.lastnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lastname',
                ),
                validator: Validators.lastnamelValidator(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: widget.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: Validators.emailValidator(),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: widget.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: Validators.passwordValidator(),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: passwordConfirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                ),
                validator: (value) {
                  if (value == "" || value != widget.passwordController.text) {
                    return 'Please make sure your passwords match';
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isCompany,
                  onChanged: (value) {
                    setState(() {
                      isCompany = value!;
                    });
                  },
                ),
                Text("I am a company",  style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            if (isCompany)
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: widget.companyController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company name',
                  ),
                  validator: Validators.generalValidator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
