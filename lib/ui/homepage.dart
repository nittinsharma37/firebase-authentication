import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import '../service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final nav = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child:
                    Text('Welcome, ${AuthService().getCurrentUser()?.email}')),
          ),
          ElevatedButton(
            onPressed: () async {
              await verifyEmail(authService, snackbar);
            },
            child: const Text(
              "Verify email",
            ),
          ),
          TextButton(
            onPressed: () async {
              await authService.signout();
              nav.pushReplacement(
                MaterialPageRoute(
                    builder: (_) =>
                        LoginPage()), // Replace with your next screen
              );
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

  Future<void> verifyEmail(
      AuthService authService, ScaffoldMessengerState snackbar) async {
    //get user from service
    User? user = authService.getCurrentUser();

    //check if user is already verified and exit early if true
    if (user?.emailVerified ?? false) {
      snackbar.showSnackBar(const SnackBar(content: Text('Already verified!')));
      return;
    }

    //reload user. This is necessary as the cached user isn't refreshed and the verifyEmail value never changes
    await authService.reloadUser();
    //get the reloaded user
    user = authService.getCurrentUser();

    //check if the user is null. This is not expected but could happen if the user is deleted since being verified
    if (user == null) {
      snackbar.showSnackBar(const SnackBar(content: Text('User not found!')));
      return;
    }

    //if the user is verified after reload, display that and exit, otherwise initiate verification
    //one downside here is that user could spam the mail by clicking this without going to her email to actually verify
    //perhaps we should limit this to once every 3 minutes or something?
    if (user.emailVerified) {
      snackbar
          .showSnackBar(const SnackBar(content: Text('You are now verified!')));
    } else {
      //send verification email
      await authService.sendEmailVerification();
      snackbar.showSnackBar(const SnackBar(
          content: Text(
              'Check your email for verification code, then come back here to complete verification process!')));
    }
    return;
  }
}
