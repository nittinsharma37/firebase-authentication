import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service/auth_service.dart';
import 'ui/homepage.dart';
import 'ui/login_choice.dart';
import 'model/usermodel.dart';

class AuthSelector extends StatelessWidget {
  const AuthSelector({super.key});

  Future<void> reloadUser() async {
    //this is used to reload user
    //reloading ensures that we have the latest info from firebase
    //without reload, old data is read from cache
    print('debug_auth: user reloaded');
    AuthService authService = AuthService();
    await authService.reloadUser();
  }

  @override
  Widget build(BuildContext context) {
    print('debug_auth: authSelector rebuilt');

    //this widget listens to stream and rebuilds every time there is a change in user (e.g. sign out)
    //this will navigate to either login or home page
    final user = Provider.of<UserModel?>(context);

    if (user != null) {
      return FutureBuilder(
        future: reloadUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Display a loading spinner while fetching data
          } else if (snapshot.hasError) {
            return LoginChoicePage();
          } else {
            return const HomePage();
          }
        },
      );
    } else {
      return LoginChoicePage();
    }
  }
}
