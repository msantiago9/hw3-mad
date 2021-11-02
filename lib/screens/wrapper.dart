import 'package:flutter/material.dart';
import 'package:hw3marjon/models/user.dart';
import 'package:hw3marjon/screens/auth/authscreen.dart';
import 'package:hw3marjon/screens/homepage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This returns either Home or Authenticate Widget, depending on login status.
    //Basically this class just decides whether to go to the Authentication screen, or the Home screen.

    final user = Provider.of<UserData?>(context);
    if (user == null) {
      return Auth();
    } else {
      return HomePage();
    }
  }
}
