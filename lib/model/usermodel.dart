enum AuthType { unknown, email, google }

class UserModel {
  String userId;
  String name;
  String email;
  bool emailVerified;
  AuthType authType;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.authType,
  });
}
