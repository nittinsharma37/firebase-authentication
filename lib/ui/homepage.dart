import 'package:app_auth/model/usermodel.dart';
import 'package:app_auth/service/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
        actions: [
          TextButton(
            onPressed: () async {
              await _authService
                  .signout()
                  // ignore: avoid_print
                  .then((value) => print(value.toString()));
            },
            child: Row(
              children: const [
                Icon(Icons.logout, color: Colors.white),
                Text(
                  " Sign out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "User Email: ${widget.user.email}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "User Id: ${widget.user.userId}",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
