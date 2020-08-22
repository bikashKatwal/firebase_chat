import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  var _userEmailAddress = '';
  var _userUserName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      print(_userEmailAddress);
      print(_userUserName);
      print(_userPassword);
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
                        if (value.isEmpty || !value.contains('@'))
                          return 'Please enter a valid email address';
                        return null;
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
                          if (value.isEmpty || value.length < 5)
                            return 'Please enter atleast 4 character';
                          return null;
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
                        if (value.isEmpty || value.length < 5)
                          return 'Please enter a valid email address';
                        return null;
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
                        onPressed: _trySubmit),
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
