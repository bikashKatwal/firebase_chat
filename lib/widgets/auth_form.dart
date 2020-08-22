import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String password, BuildContext ctx)
      submitFormForLogin;
  final Function(
          String email, String userName, String password, BuildContext ctx)
      submitFormForCreateNewUser;

  const AuthForm(
      {Key key, this.submitFormForLogin, this.submitFormForCreateNewUser})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  var _userEmailAddress = '';
  var _userUserName = '';
  var _userPassword = '';

  void _trySubmitToLogin() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFormForCreateNewUser(
          _userEmailAddress, _userUserName, _userPassword, context);
    }
  }

  void _trySubmitToCreateNewAccount() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFormForCreateNewUser(
          _userEmailAddress, _userUserName, _userPassword, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email address'),
                      onSaved: (newValue) {
                        _userEmailAddress = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          return (value.isEmpty || value.length < 5)
                              ? 'Please enter atleast 4 character'
                              : null;
                        },
                        onSaved: (newValue) {
                          _userUserName = newValue;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        return (value.isEmpty || value.length < 6)
                            ? 'Please enter password more than 6 character'
                            : null;
                      },
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: _isLogin
                            ? _trySubmitToLogin
                            : _trySubmitToCreateNewAccount),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
