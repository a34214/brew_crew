import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/laoding.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Laoding()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: const Text(
                'Sign up to Brew Crew',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: const Text('sign in'),
                  icon: const Icon(Icons.person),
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter a valid email'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) => value == null || value.length < 6
                            ? 'Enter a password 6+ long'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState?.validate() ?? false) {
                              setState(() => loading = false);
                              dynamic result = await _auth
                                  .signUpWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Please enter a valid email address';
                                  loading = false;
                                });
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.pink[400]),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(height: 20.0),
                      Text(
                        error,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )),
            ));
  }
}
