import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hw3marjon/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hw3marjon/models/user.dart';
import 'package:hw3marjon/screens/wrapper.dart';
import 'package:hw3marjon/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      catchError: (User, UserData) => null,
      value: AuthService()
          .user, //Listens to the auth change, services/auth.dart for more info
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
