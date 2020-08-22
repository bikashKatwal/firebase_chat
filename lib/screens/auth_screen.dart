import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService _authService = AuthService();
  User _authUserResult;
  ErrorMessage _authUserError;

  bool isLogging = false;
  bool isCreatingAccount = false;
  void _submitAuthFormToLogin(
      String email, String password, BuildContext context) async {
    _authUserResult =
        await _authService.submitAuthFormForLogin(email, password);
    if (_authUserResult == null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('${_authUserResult.email} is logged in')));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(_authUserError.errorMessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  void _submitAuthFormToCreateNewUser(String email, String userName,
      String password, BuildContext context) async {
    _authUserResult =
        await _authService.submitAuthFormForSignup(email, userName, password);
    if (_authUserResult != null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('${_authUserResult.email} is created')));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(_authUserError.errorMessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitFormForLogin: _submitAuthFormToLogin,
        submitFormForCreateNewUser: _submitAuthFormToCreateNewUser,
      ),
    );
  }
}
