import 'package:flutter/material.dart';
import 'package:hw3marjon/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

String email = '';
String password = '';

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        elevation: 0.0,
        title: Text("Sign in"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              TextFormField(
                //Email
                validator: (val) => val!.isEmpty ? 'Enter an email.' : null,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(height: 15.0),
              TextFormField(
                //Password
                validator: (val) => val!.isEmpty ? 'Enter a password.' : null,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    dynamic result = await _auth.signIn(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Username or Password is incorrect.';
                      });
                    }
                    print(email + ", " + password);
                  }
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 8),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
