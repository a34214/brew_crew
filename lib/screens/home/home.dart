import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: const [],
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text(
            'Brew Crew',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => showSettingsPanel(),
              label: const Text('setting'),
              icon: const Icon(Icons.settings),
            ),
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              label: const Text('logout'),
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: const BrewList(),
        ),
      ),
    );
  }
}
