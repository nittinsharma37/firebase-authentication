class UserModel {
  String userId;
  String name;
  String email;
  bool emailVerified;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.emailVerified,
  });
}
