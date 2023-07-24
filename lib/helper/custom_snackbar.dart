import 'package:flutter/material.dart';

showCustomSnackBar(String toshow, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        toshow,
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}
