import 'package:flutter/material.dart';
import 'package:rewardscard/ui/login.dart';
import '../service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final nav = Navigator.of(context);

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
                await authService.signout();
                nav.pushReplacement(
                  MaterialPageRoute(
                      builder: (_) =>
                          LoginPage()), // Replace with your next screen
                );
              },
              child: const Text(
                "Sign Out",
              ))
        ],
      ),
    );
  }
}
