import 'package:chat_app/services/auth_service.dart';
import 'file:///D:/udemy/chat_app/lib/widgets/auth/auth_form.dart';
import 'file:///D:/udemy/chat_app/lib/widgets/common/common_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService _authService = AuthService();
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  //Submit to log in
  void _submitAuthFormToLogin(
      String email, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      var result = await _authService.submitAuthFormForLogin(email, password);
      await showSnackBar(globalScaffoldKey,
          Text('${result.user.email} is logged in'), Colors.black);
    } on PlatformException catch (e) {
      var message = 'Could not log in';
      message = (e.message != null) ? e.message : message;
      await showSnackBar(
          globalScaffoldKey, Text(message), Theme.of(context).errorColor);
    } catch (e) {
      print("Login in Issue:" + e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  //Submit to create a new user
  void _submitAuthFormToCreateNewUser(String email, String userName,
      String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      var result = await _authService.submitAuthFormForSignup(
          email: email, userName: userName, password: password);
      setState(() {
        isLoading = false;
      });

      await Firestore.instance
          .collection('users')
          .document(result.user.uid)
          .setData({
        'username': userName,
        'email': result.user.email,
      });
    } on PlatformException catch (e) {
      var message = 'Oops!Something went wrong while creating the user';
      message = (e.message != null) ? e.message : message;
      await showSnackBar(
          globalScaffoldKey, Text(message), Theme.of(context).errorColor);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: globalScaffoldKey,
      body: AuthForm(
        submitFormForLogin: _submitAuthFormToLogin,
        submitFormForCreateNewUser: _submitAuthFormToCreateNewUser,
        isLoading: isLoading,
      ),
    );
  }
}
