import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Laoding extends StatelessWidget {
  const Laoding({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPulse(
        color: Theme.of(context).colorScheme.inversePrimary,
        size: 50.0,
      ),
    );
  }
}
