import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  final emailController;
  final passwordController;
  final companyController;
  final formKey;

  const SignupForm(
      {this.emailController = TextEditingController,
      this.passwordController = TextEditingController,
      this.companyController = TextEditingController,
      this.formKey = FormState,
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
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
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
                validator: (value) {
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
                controller: widget.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
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
                controller: passwordConfirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value != widget.passwordController.text) {
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
                const Text("I am a company"),
              ],
            ),
            if (isCompany)
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: widget.companyController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}