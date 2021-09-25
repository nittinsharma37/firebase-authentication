import 'package:app_auth/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj from firebase user

  UserModel? _userFromFirebase(User user) {
    return UserModel(userId: user.uid, name: user.displayName,email: user.email,);
  }

  //auth changes user stream

  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }

  // Future signinAnon() async {
  //   try {
  //     UserCredential cred = await _auth.signInAnonymously();
  //     User? user = cred.user;
  //     // print(user);
  //     return _userFromFirebase(user!);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  // SIGN UP WITH EMAIL AND PASSWORD

  Future signUpWithEmailPassword({required String email, required String name, required String password}) async{
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = cred.user;
      return _userFromFirebase(user!);
    } catch (e) {
       // ignore: avoid_print
       print(e.toString());
      return null;
    }

  }



  //sign in  with email and password


  Future signinUsingEmailPassword(String email, String pass) async{

    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = cred.user;
      return _userFromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }

  }


  //signout
  Future signout() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future resetPassword({required String email}) async{
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

}

