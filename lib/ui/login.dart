


import 'package:app_auth/service/auth_service.dart';
import 'package:app_auth/ui/forgotpassword.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  const LoginPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loadingStuff = false;

  //field vars

  String _errors = "";
  String _emailVal = "";
  String _passwordVal = "";

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
                    height: size.height * 0.15,
                    child: Text(
                      "Sign In.",
                      style: Theme.of(context).textTheme.headline1,
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
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            validator: (val) => val!.length < 6
                                ? 'Enter a valid password'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                _passwordVal = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          loadingStuff
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    // ignore: empty_statements
                                    if (!_formKey.currentState!.validate()) ;
                                    setState(() {
                                      loadingStuff = true;
                                    });
                                    dynamic result = await _authService
                                        .signinUsingEmailPassword(
                                            _emailVal, _passwordVal);
                                    if (result == null) {
                                      setState(() {
                                        _errors =
                                            "There is a problem with signing in the user check the credentials ";
                                        loadingStuff = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(_errors)));
                                      });
                                    } else {
                                      // ignore: avoid_print
                                      print(
                                          "signed in succesfully 😊👍👍👍🤞🤞😍👌👌");
                                    }
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
                                        "Sign In",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () {
                                        widget.toggleView();
                                      },
                                      child: const Text(
                                        "Create an account.",
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPassword()));
                                      },
                                      child: const Text(
                                        "Forgot Password ?",
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                              ]),
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
