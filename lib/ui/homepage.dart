import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/signinresult.dart';
import '../model/usermodel.dart';
import '../service/auth_service.dart';
import 'shared.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('debug_auth: HomePage rebuilt');

    final AuthService authService = AuthService();
    final snackbar = ScaffoldMessenger.of(context);
    final userProvider = Provider.of<UserModel?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                  'Welcome ${userProvider?.email ?? 'unknown'} (${userProvider?.emailVerified ?? false ? 'verified' : 'unverified'}) Provider: ${(userProvider?.authType ?? AuthType.email) == AuthType.google ? 'Google' : 'Email'}'),
            ),
          ),
          Visibility(
            visible: !(userProvider?.emailVerified ??
                false), //hide verify email button if the user is verified already
            child: ElevatedButton(
              onPressed: () async {
                await verifyEmail(authService, snackbar,
                    userProvider); //send verification email
              },
              child: const Text(
                "Verify email",
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              SignInResult? result = await authService.signout();
              snackbarHandler(result, snackbar, 'You have signed out');

              //do not navigate from here, user change will cause AuthSelector rebuild which will return the correct page
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> verifyEmail(AuthService authService,
      ScaffoldMessengerState snackbar, UserModel? user) async {
    //check if user is already verified and exit early if true
    if (user?.emailVerified ?? false) {
      snackbar.showSnackBar(const SnackBar(content: Text('Already verified!')));
      return;
    }

    //send verification email
    SignInResult result = await authService.sendEmailVerification();

    snackbarHandler(result, snackbar,
        'Check your email (including spam folder) for verification link, then come back here to complete verification process!');

    result = await authService.signout();

    //display errors if any
    snackbarHandler(result, snackbar, '');
    return;
  }
}
