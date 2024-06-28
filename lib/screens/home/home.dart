import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text(
          'Brew Crew',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text('logout'),
            icon: const Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
