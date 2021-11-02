import 'package:flutter/material.dart';
import 'package:hw3marjon/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fname = '';
  String lname = '';
  String error = '';
  var spacing = 7.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        elevation: 0.0,
        title: Text("Sign Up"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: spacing),
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
              SizedBox(height: spacing),
              TextFormField(
                //Password
                validator: (val) => val!.length < 6
                    ? 'Password needs to be at least 6 characters long.'
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(height: spacing),
              TextFormField(
                //First Name
                validator: (val) =>
                    val!.isEmpty ? 'Enter your First Name.' : null,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                onChanged: (val) {
                  fname = val;
                },
              ),
              SizedBox(height: spacing),
              TextFormField(
                //Last Name
                validator: (val) =>
                    val!.isEmpty ? 'Enter your Last Name.' : null,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                onChanged: (val) {
                  lname = val;
                },
              ),
              SizedBox(height: spacing),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    dynamic result =
                        await _auth.register(email, password, fname, lname);
                    if (result == null) {
                      setState(() {
                        error = 'Invalid email';
                      });
                    }
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
