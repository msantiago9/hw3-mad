import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hw3marjon/models/user.dart';
import 'package:hw3marjon/services/db.dart';

class AuthService {
  /// Features:
  /// Anonymous sign-in
  /// Email+Password sign-in
  /// Registration with email
  /// Sign out

  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserData _toUserData(User? user) {
    if (user != null) {
      return UserData(uid: user.uid);
    } else {
      return UserData(uid: "");
    }
  }

  //This will detect an authentication change.
  //Returns:
  //null, if the user signs out, or if the user was never signed in
  //UserData, if the user signs in.
  Stream<UserData> get user {
    return _auth.authStateChanges().map((User? user) => _toUserData(user!));
  }

  Future Anon() async {
    try {
      //NOTE TO SELF: OLD FIREBASE USES AuthResult IN PLACE OF UserCredential
      //NOTE TO SELF: OLD FIREBASE USES FirebaseUser IN PLACE OF User
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _toUserData(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _toUserData(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(
      String email, String password, String fname, String lname) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      await DBServ(uid: user!.uid).update(fname, lname, "customer");
      return _toUserData(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("error.");
      print(e.toString());
      return null;
    }
  }
}
