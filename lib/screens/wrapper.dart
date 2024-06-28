import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget
    final userStatus = Provider.of<CustomUser?>(context);
    if (userStatus == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
