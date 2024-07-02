import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/laoding.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({super.key});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? currentName;
  int? currentStrength;
  String? currentSugars;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return const Center(
        child: Text('no user found!'),
      );
    }
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a name'
                        : null,
                    onChanged: (value) => setState(() => currentName = value),
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('$sugar sugars'));
                    }).toList(),
                    onChanged: (value) => setState(() => currentSugars = value),
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: (currentStrength ?? userData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[currentStrength ?? userData.strength],
                    onChanged: (value) =>
                        setState(() => currentStrength = value.round()),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState?.validate() ?? false) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            currentName ?? userData.name,
                            currentSugars ?? userData.sugars,
                            currentStrength ?? userData.strength);
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.pink[400]),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Laoding();
          }
        });
  }
}
