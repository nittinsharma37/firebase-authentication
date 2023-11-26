import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/signinresult.dart';
import '../model/usermodel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StreamController<UserModel?> _userController =
      StreamController<UserModel?>();
  bool isInitilized = false;

  //create user obj from firebase user
  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      userId: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      emailVerified: user.emailVerified,
    );
  }

  // Auth changes user stream
  Stream<UserModel?> get user => _userController.stream;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      final UserModel? userModel = _userFromFirebase(user);
      _userController.add(userModel);
      print('debug_auth: emit event. data: $user');
    });
  }

  void dispose() {
    _userController.close();
  }

  // SIGN UP WITH EMAIL AND PASSWORD
  Future<SignInResult> signUpWithEmailPassword(
      {required String email,
      required String name,
      required String password}) async {
    UserModel? user;
    String? err;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        user = _userFromFirebase(cred.user!);
      }
    } catch (e) {
      err = e.toString();
    }
    return SignInResult(user: user, error: err);
  }

  //sign in  with email and password
  Future<SignInResult> signinUsingEmailPassword(
      String email, String pass) async {
    UserModel? user;
    String? err;
    try {
      UserCredential cred =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (cred.user != null) {
        user = _userFromFirebase(cred.user!);
      } else {
        err = 'No user found!';
      }
    } catch (e) {
      // Handle error and return it along with null user
      err = e.toString();
    }
    return SignInResult(user: user, error: err);
  }

  //signout
  Future<SignInResult> signout() async {
    String? err;
    try {
      await _auth.signOut();
      // _userController.add(null); // Add user data to the stream
    } catch (e) {
      // ignore: avoid_print
      err = e.toString();
    }
    return SignInResult(user: null, error: err);
  }

  //send reset password email (this also verifies emails)
  Future<SignInResult> resetPassword({required String email}) async {
    String? err;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      err = e.toString();
    }
    return SignInResult(user: null, error: err);
  }

  //Send "verify email" email
  Future<SignInResult> sendEmailVerification() async {
    User? user = _auth.currentUser;
    String? err;
    if (user != null) {
      try {
        await user.sendEmailVerification();
      } catch (e) {
        err = e.toString();
      }
    } else {
      err = 'Error: No user found!';
    }
    return SignInResult(user: null, error: err);
  }

  Future<SignInResult> reloadUser() async {
    User? user = _auth.currentUser;

    String? err;
    if (user != null) {
      try {
        await user.reload();
        user = _auth.currentUser;
        _userController.add(_userFromFirebase(user));
      } catch (e) {
        err = e.toString();
      }
    } else {
      err = 'Error: No user found!';
    }
    return SignInResult(user: null, error: err);
  }
}
