import 'usermodel.dart';

class SignInResult {
  final UserModel? user;
  final String? error;

  SignInResult({this.user, this.error});
}
