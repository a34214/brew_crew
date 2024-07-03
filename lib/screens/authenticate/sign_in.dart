import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/laoding.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            // backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text(
                'Sign in to Brew Crew',
                // style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: const Text('sign up'),
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
                      decoration: getInputDecoration(context)
                          .copyWith(hintText: 'Email'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your email'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: getInputDecoration(context)
                          .copyWith(hintText: 'Password'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your password'
                          : null,
                      obscureText: true,
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
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Email or password is not correct';
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
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      error,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
