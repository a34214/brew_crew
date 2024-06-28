import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Laoding extends StatelessWidget {
  const Laoding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(
        child: SpinKitPulse(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
