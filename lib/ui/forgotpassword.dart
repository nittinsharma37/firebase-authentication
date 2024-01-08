import 'package:flutter/material.dart';
import '../service/auth_service.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  static const routeName = 'forgotpassword';
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //field vars
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final snackbar = ScaffoldMessenger.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Forgot Password.",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _authService
                                  .resetPassword(email: emailController.text)
                                  .then((value) {
                                snackbar.showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "An Email to reset password have been sent !")),
                                );
                              }).catchError((err) {
                                snackbar.showSnackBar(
                                  SnackBar(
                                    content: Text('Error: $err'),
                                  ),
                                );
                              });
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
                                "Send Email",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Sign In.",
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
