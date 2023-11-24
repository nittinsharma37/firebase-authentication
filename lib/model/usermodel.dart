import 'package:rewardscard/model/signinresult.dart';

class UserModel {
  String userId;
  String name;
  String email;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
  });

  void updatePropertiesFromSignInResult(SignInResult result) {
    userId = result.user!.userId;
    name = result.user!.name;
    email = result.user!.email;
  }
}
