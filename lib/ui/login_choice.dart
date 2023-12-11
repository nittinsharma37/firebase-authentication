import 'package:flutter/material.dart';
import 'package:rewardscard/model/signinresult.dart';
import '../service/auth_service.dart';
import 'login.dart';
import 'shared.dart';

class LoginChoicePage extends StatelessWidget {
  LoginChoicePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Choices'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildAuthButton(
              text: 'Email',
              icon: Icons.email,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            const SizedBox(height: 16.0),
            buildAuthButton(
              text: 'Google',
              icon: Icons.account_box,
              onPressed: () async {
                // Handle Google authentication
                SignInResult result = await _authService.signInWithGoogle();
                if (result.user == null || result.error != null) {
                  snackbarHandler(result, snackbar, '');
                }
              },
            ),
            // const SizedBox(height: 16.0),
            // buildAuthButton(
            //   text: 'Facebook',
            //   icon: Icons.facebook,
            //   onPressed: () {
            //     // Handle Facebook authentication
            //   },
            // ),
            // const SizedBox(height: 16.0),
            // buildAuthButton(
            //   text: 'Apple',
            //   icon: Icons.apple,
            //   onPressed: () {
            //     // Handle Apple authentication
            //   },
            // ),
            // const SizedBox(height: 16.0),
            // buildAuthButton(
            //   text: 'Microsoft',
            //   icon: Icons.window,
            //   onPressed: () {
            //     // Handle Microsoft authentication
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(text, style: const TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }
}
