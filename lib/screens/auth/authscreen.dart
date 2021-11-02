import 'package:flutter/material.dart';
import 'package:hw3marjon/screens/auth/register.dart';
import 'package:hw3marjon/screens/auth/signin.dart';

class Auth extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Auth> {
  bool signIn = true;
  void toggleView() {
    setState(() => signIn = !signIn);
  }

  @override
  Widget build(BuildContext context) {
    return signIn
        ? SignIn(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
