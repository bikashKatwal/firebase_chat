import 'package:chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(userId: user.uid, userName: user.displayName, email: user.email)
        : null;
  }

  ErrorMessage _updateErrorMessage({String errorMessage}) {
    return ErrorMessage(errorMessage: errorMessage);
  }

  Future submitAuthFormForLogin(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _firebaseUser = authResult.user;
      return _userFromFirebaseUser(_firebaseUser);
    } on PlatformException catch (e) {
      var message = 'An error occured, please check you credentials';
      message = (e.message != null) ? e.message : message;
      return _updateErrorMessage(errorMessage: message);
    } catch (err) {
      print(err.toString());
    }
  }

  Future submitAuthFormForSignup(
      String email, String password, String userName) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _firebaseUser = authResult.user;
      return _userFromFirebaseUser(_firebaseUser);
    } on PlatformException catch (e) {
      var message = 'Oops!Something went wrong';
      message = (e.message != null) ? e.message : message;
      return message;
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
