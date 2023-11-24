import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/homepage.dart';
import 'ui/login.dart';
import 'model/usermodel.dart';

class AuthSelector extends StatelessWidget {
  const AuthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {
      return const HomePage();
    } else {
      return LoginPage();
    }
  }
}
