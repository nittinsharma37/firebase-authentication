import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/signinresult.dart';
import '../model/usermodel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj from firebase user
  UserModel? _userFromFirebase(User user) {
    return UserModel(
      userId: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  //auth changes user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) {
      return _userFromFirebase(user!);
    });
  }

  //reload user from Firebase.
  Future<void> reloadUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    } else {
      await user.reload();
    }
  }

  //Return current user
  User? getCurrentUser() {
    return _auth.currentUser;
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
      // ignore: avoid_print
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
      }
    } catch (e) {
      // Handle error and return it along with null user
      err = e.toString();
    }
    return SignInResult(user: user, error: err);
  }

  //signout
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  //send reset password email (this also verifies emails)
  Future resetPassword({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //Send "verify email" email
  Future<bool> sendEmailVerification() async {
    User? user = _auth.currentUser;
    bool rtn = false;
    if (user != null) {
      await user.sendEmailVerification();
      rtn = true;
    }
    return rtn;
  }
}
