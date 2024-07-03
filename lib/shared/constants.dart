import "package:flutter/material.dart";

InputDecoration getInputDecoration(BuildContext context) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(
          color: Theme.of(context).colorScheme.inversePrimary, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Theme.of(context).colorScheme.inversePrimary, width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
  );
}
