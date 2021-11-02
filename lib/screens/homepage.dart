import 'package:flutter/material.dart';
import 'package:hw3marjon/screens/chatpage.dart';
import 'package:hw3marjon/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Chats"),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.account_box),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
