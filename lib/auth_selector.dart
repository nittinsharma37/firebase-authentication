import 'package:app_auth/model/usermodel.dart';
import 'package:app_auth/service/authenticate.dart';
import 'package:app_auth/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthSelector extends StatefulWidget {
  const AuthSelector({Key? key}) : super(key: key);

  @override
  _AuthSelectorState createState() => _AuthSelectorState();
}

class _AuthSelectorState extends State<AuthSelector> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {
      return HomePage(user: user,);
    } else {
      return const Authenticate();
    }
  }
}