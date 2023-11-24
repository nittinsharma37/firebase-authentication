import 'package:flutter/material.dart';
import 'package:rewardscard/model/signinresult.dart';
import '../service/auth_service.dart';
import 'homepage.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //field vars
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final snackbar = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign Up.",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter a valid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
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
                    SizedBox(
                      height: size.height * 0.05,
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
                                await _authService.signUpWithEmailPassword(
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text);
                            if (result.error != null || result.user == null) {
                              snackbar.showSnackBar(SnackBar(
                                  content:
                                      Text(result.error ?? "Unknown error")));
                            } else {
                              nav.pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const HomePage()), // Replace with your next screen
                              );
                            }
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
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
