import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _appLogo(),
          _LoginField(),
          _appFooter()
        ],
      ),
    );
  }

  Widget _appLogo() {
    return Container(
      child: Image.network('https://www.google.com')
    );
  }

  Widget _appFooter() {
    return Container(
      child: const Text('Copyrights 2020'),
    );
  }
}

class _LoginField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<_LoginField> {

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
          ),
          TextFormField(
            controller: _passwordController,
          ),
        ]
      )
    );
  }
}