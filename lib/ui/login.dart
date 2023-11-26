import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../model/signinresult.dart';
import 'forgotpassword.dart';
import 'signup.dart';
import 'shared.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    print('debug_auth: login rebuilt');
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign In.",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        validator: (val) =>
                            val!.length < 6 ? 'Enter a valid password' : null,
                        obscureText: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SignInResult result =
                                  await _authService.signinUsingEmailPassword(
                                emailController.text,
                                passwordController.text,
                              );
                              //display error if any
                              snackbarHandler(result, snackbar, '');
                              //do not navigate here, change to user will cause AuthSelector to rebuild and return the right page
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Ink(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              child: Text(
                                "Sign In",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: const Text(
                      "Create account",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      },
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 14),
                      )),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
