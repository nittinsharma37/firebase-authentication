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
              User? user = authService.getCurrentUser();
              if (user?.emailVerified ?? false) {
                snackbar.showSnackBar(
                    const SnackBar(content: Text('Already verified!')));
                return;
              }

              await authService.reloadUser();
              user = authService.getCurrentUser();

              if (user == null) {
                snackbar.showSnackBar(
                    const SnackBar(content: Text('User not found!')));
                return;
              }
              if (user.emailVerified) {
                snackbar.showSnackBar(
                    const SnackBar(content: Text('You are now verified!')));
                
              } else {
                await authService.sendEmailVerification();
                snackbar.showSnackBar(const SnackBar(
                    content: Text(
                        'Check your email for verification code, then come back here to complete verification process!')));
              }
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
}
