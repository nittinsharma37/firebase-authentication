import 'package:app_auth/service/auth_service.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loadingStuff = false;

  //field vars

  String _errors = "";
  String _emailVal = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    height: size.height * 0.25,
                    child: Text(
                      "Forgot Password.",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() {
                                _emailVal = val;
                              });
                            },
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
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          loadingStuff
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) ;
                                    setState(() {
                                      loadingStuff = true;
                                    });
                                    _authService
                                        .resetPassword(email: _emailVal)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "An Email to reset password have been sent !")));
                                    }).catchError((err) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "There is a problem, Please try again later!"),
                                        ),
                                      );
                                    });
                                    setState(() {
                                      loadingStuff = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
